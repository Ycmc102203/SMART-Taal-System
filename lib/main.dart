import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/backend/google_sheets_api.dart';
import 'package:smart_taal_system/enumerator/screens/verify_email_page.dart';
import 'package:smart_taal_system/forms/input/form_page_one.dart';
import 'package:smart_taal_system/forms/input/form_page_two.dart';
import 'package:smart_taal_system/enumerator/screens/home_page.dart';
import 'package:smart_taal_system/enumerator/screens/signup_page.dart';
import 'package:smart_taal_system/enumerator/screens/login_page.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'backend/user_db.dart';
import 'enumerator/screens/onboarding_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'enumerator/screens/transition_page.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSheetsApi.init();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  ConnectivityResult result = ConnectivityResult.none;
  bool hasInternet = false;
  AudioCache audioCache = AudioCache();
  late StreamSubscription<User?> user;
  int? initScreen;
  String? firstName;
  String? lastName;

  Map _userData = {
    'firstName': '',
    'lastName': '',
    'nickName': '',
    'status': ''
  };

  @override
  void initState() {
    checkInternet();
    //_queryUser();
    //print(_queryUser());
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
      _queryUser();
      print("userData is: ${_userData}");
    });
  }

  @override
  dispose() {
    subscription.cancel();
    internetSubscription.cancel();
    super.dispose();
  }

  _queryUser() async {
    Database db = await DatabaseHelperThree.instance.database;
    List<Map> result = await db.rawQuery('SELECT * FROM userDataData');
    for (var x in result) {
      setState(() {
        _userData = x;
      });
    }
    setState(() {
      firstName = _userData["firstName"];
      lastName = _userData["lastName"];
    });
  }

  checkInternet() {
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
  }

  checkIfSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("initScreen", 1);
    setState(() async {
      initScreen = await prefs.getInt("initScreen") as int;
      print("set: ${initScreen}");
    });
  }

  // Future<String> _queryUser() async {
  //   Database db = await DatabaseHelperThree.instance.database;
  //   List<Map> result = await db.rawQuery('SELECT * FROM userDataData');
  //   return await result[0]["status"];
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Enumerator Profile',
        theme: ThemeData(
            fontFamily: 'Montserrat',
            iconTheme: IconThemeData(color: Colors.white),
            primarySwatch: Colors.purple),
        initialRoute: (FirebaseAuth.instance.currentUser == null)
            ? '/onboarding'
            : '/home',
        //'/onboarding',
        // ((_queryUser() == "") &&
        //         (FirebaseAuth.instance.currentUser == null))
        //     ? '/onboarding'
        //     : ((_queryUser() == 'logged out') &&
        //             (FirebaseAuth.instance.currentUser == null))
        //         ? '/login'
        //         : ((_queryUser() == 'logged in') ||
        //                 (FirebaseAuth.instance.currentUser != null))
        //             ? '/home'
        //             : '/onboarding',
        routes: <String, WidgetBuilder>{
          '/onboarding': (BuildContext context) => OnBoarding(),
          '/signup': (BuildContext context) => SignupPage(),
          '/login': (BuildContext context) => LoginPage(),
          '/transition': (BuildContext context) => TransitionPage(),
          '/home': (BuildContext context) =>
              MyHomePage(hasInternet: hasInternet),
          '/form_one': (BuildContext context) => NewActivity(),
          '/verify_email': (BuildContext context) => VerifyEmailPage(),
          NewSpecies.routeName: (context) => NewSpecies(),
          //'/form_1': (BuildContext context) => addActivity(context),
        });
  }
}
