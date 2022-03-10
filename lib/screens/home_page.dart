import 'dart:async';

import 'package:animations/animations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:smart_taal_system/screens/dashboard_page.dart';
import 'package:smart_taal_system/screens/data_table_page.dart';
import 'package:smart_taal_system/forms/input/form_page_one.dart';
import 'package:smart_taal_system/screens/manual_page.dart';
import 'package:smart_taal_system/screens/settings_page.dart';
import 'package:smart_taal_system/widgets/appbar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../forms/input/arguments.dart';

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

  @override
  void initState() {
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.result = result;
      });
      if (hasInternet == true) {
        showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Konektado ka na sa internet!",
            ));
      } else if (hasInternet == false) {
        showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: "Na-diskonek ka sa internet :(",
            ));
      }
    });
    setState(() {});
    super.initState();
  }

  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    Settings(),
    Manual(),
    ActivityTable()
  ];

  Widget currentScreen = Dashboard();

  final PageStorageBucket bucket = PageStorageBucket();
  final double coverHeight = 125;
  final double profileHeight = 45;

  int? selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: buildTop(),
      ),
      body: PageStorage(
          child: PageTransitionSwitcher(
              duration: Duration(milliseconds: 350),
              transitionBuilder: (child, animation, secondaryAnimation) =>
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
        curveSize: 90,
        height: 70,
        style: TabStyle.fixedCircle,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.library_books, title: 'Mga Tala'),
          TabItem<Widget>(
              icon: Transform.scale(
                scale: 1,
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/form_one',
                        arguments: FormOneArguments(dateTime));
                  },
                  elevation: 10,
                  fillColor: widget.hasInternet ? Colors.green : Colors.red,
                  child: Icon(
                    Icons.add,
                    size: 45.0,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(0.0),
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.white, width: 5)),
                ),
              ),
              title: ''),
          TabItem(icon: Icons.book, title: 'Manwal'),
          TabItem(icon: Icons.settings, title: 'Settings'),
        ],
        initialActiveIndex: 0,
        onTap: (int i) {
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
            currentScreen = Settings();
            setState(() {});
          }
        },
      ),
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
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
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/Maam Mich.jpg'),
              ))));

  Widget buildTop() {
    return Container(
        decoration: BoxDecoration(
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
        height: 100,
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
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: buildProfileImage()))
          ],
        ));
  }

  Widget profileName() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: widget.hasInternet
                    ? [Colors.green, Colors.lightGreen, Colors.white]
                    : [Colors.red, Colors.redAccent, Colors.white],
                stops: [0.025, 0.25, 0.5],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        width: MediaQuery.of(context).size.width,
        height: 65,
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width / 4, 5, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("Mabuhay!",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.purple,
                        fontSize: 20)),
                Text("NFRDI Enumerator",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.purple)),
              ],
            )));
  }
}
