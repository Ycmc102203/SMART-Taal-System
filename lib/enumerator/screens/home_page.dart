import 'dart:async';

import 'package:animations/animations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/backend/user_db.dart';
import 'package:smart_taal_system/forms/output/delete_form.dart';

import 'package:smart_taal_system/enumerator/screens/dashboard_page.dart';
import 'package:smart_taal_system/enumerator/screens/data_table_page.dart';
import 'package:smart_taal_system/forms/input/form_page_one.dart';
import 'package:smart_taal_system/enumerator/screens/manual_page.dart';
import 'package:smart_taal_system/widgets/appbar.dart';
import 'package:smart_taal_system/widgets/loadingIndicator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../backend/models/user_model.dart';
import '../../forms/input/arguments.dart';
import 'settings_page.dart';

class MyHomePage extends StatefulWidget {
  final hasInternet;
  MyHomePage({required this.hasInternet});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;
  DateTime dateTime = DateTime.now();
  final AudioCache player = AudioCache(prefix: 'assets/sounds/');

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  Map _userData = {};

  String firstName = '';
  String lastName = '';

  @override
  void initState() {
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.result = result;
      });
      if (hasInternet == true) {
        print(loggedInUser.firstName);

        showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Konektado ka na sa internet!",
            ));
      } else if (hasInternet == false) {
        print(loggedInUser.firstName);
        showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: "Na-diskonek ka sa internet :(",
            ));
      }
    });

    setState(() {});
    super.initState();
    sleep();
    _queryUser();
    sleep();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _queryUser() async {
    Database db = await DatabaseHelperThree.instance.database;
    List<Map> result = await db.rawQuery('SELECT * FROM userDataData');
    for (var x in result) {
      _userData = x;
    }
    setState(() {
      firstName = _userData["firstName"];
      lastName = _userData["lastName"];
    });
  }

  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    SettingsScreen(),
    Manual(),
    ActivityTable()
  ];

  Widget greeting(style, color) {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return Row(children: [
        Icon(FontAwesomeIcons.cloudSun, color: color),
        SizedBox(width: 20),
        Text("Magandang Umaga,", style: style)
      ]);
    }
    if (hour == 12) {
      return Row(children: [
        Icon(Icons.wb_sunny, color: color),
        SizedBox(width: 10),
        Text("Magandang Tanghali,", style: style)
      ]);
    }
    if (hour < 18) {
      return Row(children: [
        Icon(FontAwesomeIcons.cloudSun, color: color),
        SizedBox(width: 20),
        Text("Magandang Hapon,", style: style)
      ]);
    }
    return Row(children: [
      Icon(Icons.mode_night, color: color),
      SizedBox(width: 10),
      Text("Magandang Gabi,", style: style)
    ]);
  }

  Widget currentScreen = Dashboard();

  final PageStorageBucket bucket = PageStorageBucket();
  final double coverHeight = 125;
  final double profileHeight = 45;
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingDialog(color: Colors.green, text: "Nagloload");
          } else {
            return Scaffold(
              appBar: AppBar(
                flexibleSpace: buildTop(),
              ),
              body: PageStorage(
                  child: PageTransitionSwitcher(
                      duration: Duration(milliseconds: 350),
                      transitionBuilder:
                          (child, animation, secondaryAnimation) =>
                              FadeThroughTransition(
                                  animation: animation,
                                  secondaryAnimation: secondaryAnimation,
                                  child: child),
                      child: currentScreen),
                  bucket: bucket),
              bottomNavigationBar: ConvexAppBar(
                elevation: 5,
                color: Color.fromARGB(100, 0, 0, 0),
                gradient: LinearGradient(
                  stops: [0.25, 0.85],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    widget.hasInternet
                        ? Color.fromARGB(255, 199, 255, 188)
                        : Color.fromARGB(255, 253, 205, 205),
                    Color(0xFFffffff),
                  ],
                ),
                activeColor: Colors.purple,
                curveSize: 100,
                height: 70,
                style: TabStyle.fixedCircle,
                items: [
                  TabItem(icon: Icons.home, title: 'Home'),
                  TabItem(icon: Icons.library_books, title: 'Mga Tala'),
                  TabItem<Widget>(
                    icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.25),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                color: widget.hasInternet
                                    ? Colors.green
                                    : Colors.red,
                                blurRadius: 0.0,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize:
                                  MaterialStateProperty.resolveWith<Size>(
                                      (states) => Size(50, 50)),
                              shape: MaterialStateProperty.all<CircleBorder>(
                                  CircleBorder(
                                      side: BorderSide(
                                          color: Colors.white, width: 5))),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.lightGreen),
                              elevation:
                                  MaterialStateProperty.resolveWith<double>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return 0;
                                  return 20.0;
                                },
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/form_one',
                                  arguments: FormOneArguments(
                                      dateTime,
                                      _userData["firstName"],
                                      _userData["lastName"]));
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add,
                                size: 35.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TabItem(icon: Icons.book, title: 'Manwal'),
                  TabItem(icon: Icons.settings, title: 'Settings'),
                ],
                initialActiveIndex: 0,
                onTap: (int i) async {
                  if (i == 0) {
                    print(i);

                    currentScreen = Dashboard();
                    setState(() {});
                  }
                  if (i == 1) {
                    print(i);
                    currentScreen = ActivityTable();
                    setState(() {});
                  }
                  if (i == 3) {
                    print(i);
                    currentScreen = Manual();
                    setState(() {});
                  }
                  if (i == 4) {
                    print(i);
                    setState(() {});

                    currentScreen = SettingsScreen();
                  }
                },
              ),
            );
          }
        });
  }

  Widget buildCoverImage() => Container(
        color: Colors.purple,
        child: Image.asset(
          'assets/Taal-Lake.png',
          width: double.infinity,
          height: 100,
          fit: BoxFit.fitWidth,
        ),
      );

  Widget buildProfileImage() => Container(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 5), // changes position of shadow
        )
      ]),
      child: CircleAvatar(
          radius: profileHeight + 10,
          backgroundColor: Colors.white,
          child: CircleAvatar(
              radius: profileHeight + 5,
              backgroundColor: widget.hasInternet ? Colors.green : Colors.red,
              child: CircleAvatar(
                radius: profileHeight,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/Enumerator circle.jpg'),
              ))));

  Widget buildTop() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.purple,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(100, 0, 255, 13),
                Colors.white,
              ],
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(0, 50), // changes position of shadow
              )
            ]),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
          children: [
            buildCoverImage(),
            Positioned(
              top: 68,
              child: profileName(),
            ),
            Positioned(
                top: 40,
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: buildProfileImage()))
          ],
        ));
  }

  Widget profileName() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.purple,
            gradient: LinearGradient(
                colors: widget.hasInternet
                    ? [Colors.green, Colors.lightGreen, Colors.white]
                    : [Colors.red, Colors.redAccent, Colors.white],
                stops: [0.025, 0.25, 0.5],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        width: MediaQuery.of(context).size.width,
        height: 70,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 10.0, top: 5.0, bottom: 5.0, left: 135),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  greeting(
                      TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                          color: Colors.purple),
                      Colors.purple),
                  Text("${_userData["nickname"]} ${_userData["lastName"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                          color: Colors.purple)),
                ],
              ),
            ),
          ),
        ));
  }
}
