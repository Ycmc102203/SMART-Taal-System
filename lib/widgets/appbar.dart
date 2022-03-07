import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppBarDesign extends StatefulWidget {
  @override
  _AppBarDesignState createState() => _AppBarDesignState();
}

class _AppBarDesignState extends State<AppBarDesign> {
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  ConnectivityResult result = ConnectivityResult.none;
  bool hasInternet = true;

  void initState() {
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
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

  @override
  dispose() {
    subscription.cancel();
    internetSubscription.cancel();
    super.dispose();
  }

  final double coverHeight = 125;
  final double profileHeight = 45;

  @override
  Widget build(BuildContext context) {
    return buildTop();
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'assets/Taal-Lake.png',
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 4,
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
              backgroundColor: hasInternet ? Colors.green : Colors.red,
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
                Color.fromARGB(255, 0, 255, 13),
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
        height: MediaQuery.of(context).size.width / 3.5,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
          children: [
            buildCoverImage(),
            Positioned(
              top: MediaQuery.of(context).size.height / 10,
              child: profileName(),
            ),
            Positioned(
                top: MediaQuery.of(context).size.width / 10,
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
          stops: [
            0,
            0.50,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            hasInternet ? Colors.green : Colors.red,
            Color(0xFFffffff),
          ],
        )),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 10.5,
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
