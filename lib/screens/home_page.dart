import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:smart_taal_system/screens/dashboard_page.dart';
import 'package:smart_taal_system/screens/data_table_page.dart';
import 'package:smart_taal_system/forms/form_page_one.dart';
import 'package:smart_taal_system/screens/manual_page.dart';
import 'package:smart_taal_system/screens/settings_page.dart';
import 'package:smart_taal_system/widgets/activities_list.dart';
import '../backend/sqlfite_local_primary_db.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
  void _addActivity(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(35), topLeft: Radius.circular(35))),
        enableDrag: false,
        isScrollControlled: true,
        context: context,
        builder: (bCtx) {
          return NewActivity();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(flexibleSpace: buildTop()),
      body: PageStorage(child: currentScreen, bucket: bucket),
      bottomNavigationBar: ConvexAppBar(
        elevation: 5,
        color: Color.fromARGB(100, 0, 0, 0),
        gradient: LinearGradient(
          stops: [
            -1,
            0.90,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 205, 253, 208),
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
                    _addActivity(context);
                  },
                  elevation: 10,
                  fillColor: Colors.green,
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
        child: Image.network(
          'https://images.unsplash.com/photo-1633670057397-b12fc5289e96?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
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
          radius: profileHeight + 7,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: profileHeight,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage('assets/Maam Mich.jpg'),
          )));

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
            Color(0xFFbffbc3),
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
