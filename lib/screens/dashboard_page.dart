import 'package:flutter/material.dart';
import 'package:smart_taal_system/screens/dashboard_page.dart';
import 'package:smart_taal_system/screens/data_table_page.dart';
import 'package:smart_taal_system/forms/form_page_one.dart';
import 'package:smart_taal_system/screens/manual_page.dart';
import 'package:smart_taal_system/screens/settings_page.dart';
import 'package:smart_taal_system/widgets/activities_list.dart';
import 'package:smart_taal_system/widgets/calendar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_calendar/table_calendar.dart';
import '../backend/sqlfite_local_primary_db.dart';
import '../backend/sqlfite_local_secondary_db.dart';
import '../widgets/days_list.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 100),
            color: Colors.purple,
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Colors.purple,
            //     Color.fromARGB(255, 121, 39, 176),
            //   ],
            // )),
            child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 1), () {
                    setState(() {});
                    ;
                  });
                },
                child: RawScrollbar(
                    thumbColor: Colors.green,
                    isAlwaysShown: true,
                    radius: Radius.circular(10),
                    thickness: 7,
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: Column(children: [
                          Calendar(),
                          ActivitiesList(),
                          DaysList()
                        ]))))));
    // Scaffol
  }
}
