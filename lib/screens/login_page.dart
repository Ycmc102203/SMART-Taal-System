import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final double coverHeight = 125;

  final double profileHeight = 45;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(flexibleSpace: buildTop()),
      body: Container(color: Colors.purple),
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
              backgroundColor: Colors.green,
              child: CircleAvatar(
                radius: profileHeight,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/Maam Mich.jpg'),
              ))));

  Widget buildTop() {
    return Container(
        decoration: BoxDecoration(
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
        height: 200,
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
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 65,
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width / 4, 5, 20, 0),
            child: Row(
              children: [Text("LOG"), Text("-"), Text("IN")],
            )));
  }
}
