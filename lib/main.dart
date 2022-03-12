import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/backend/google_sheets_api.dart';
import 'package:smart_taal_system/forms/input/form_page_one.dart';
import 'package:smart_taal_system/forms/input/form_page_two.dart';
import 'package:smart_taal_system/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:smart_taal_system/screens/login_page.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'dart:async';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'screens/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSheetsApi.init();
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

  void initState() {
    checkInternet();
    setState(() {});
    super.initState();
  }

  @override
  dispose() {
    subscription.cancel();
    internetSubscription.cancel();
    super.dispose();
  }

  checkInternet() {
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
    print(hasInternet);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Enumerator Profile',
        theme: ThemeData(
            fontFamily: 'Montserrat',
            iconTheme: IconThemeData(color: Colors.white),
            primarySwatch: Colors.purple),
        initialRoute: '/home',
        routes: <String, WidgetBuilder>{
          '/onboarding': (BuildContext context) => OnBoarding(),
          '/login': (BuildContext context) => LoginPage(),
          '/home': (BuildContext context) => MyHomePage(
                hasInternet: hasInternet,
              ),
          '/form_one': (BuildContext context) => NewActivity(),
          NewSpecies.routeName: (context) => NewSpecies(),
          //'/form_1': (BuildContext context) => addActivity(context),
        });
  }
}
