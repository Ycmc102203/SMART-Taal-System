import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/backend/enumeratorOfflineData.dart';
import 'package:smart_taal_system/backend/enumeratorRawData.dart';
import 'package:smart_taal_system/backend/google_sheets_api.dart';
import 'package:smart_taal_system/backend/sqlfite_local_offline_cache.dart';
import 'package:smart_taal_system/functions/check_connection.dart';
import 'package:smart_taal_system/widgets/activities_list.dart';
import 'package:smart_taal_system/widgets/calendar.dart';
import 'package:smart_taal_system/widgets/offline_cache_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  String onlineDate = '';
  String onlineEnumerator = '';
  String onlineLandingCenter = '';
  String onlineFishingGround = '';
  String onlineTotalLandings = '';
  String onlineBoatName = '';
  String onlineFishingGear = '';
  String onlineFishingEffort = '';
  String onlineTotalBoatCatch = '';
  String onlineSampleSerialNumber = '';
  String onlineTotalSampleWeight = '';
  String onlineSpeciesName = '';
  String onlineLength = '';
  String onlineWeight = '';

  _queryOffline() async {
    Database db = await DatabaseHelperTwo.instance.database;
    int? count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM enumeratorOfflineData'));
    String countString = count.toString();
    var countInt = int.parse(countString);

    while (countInt != 0) {
      Map<String, dynamic> result = {};
      List<Map<String, dynamic>> results = await db.rawQuery(
          'SELECT * FROM enumeratorOfflineData WHERE id=?', ['$countInt']);
      for (var r in results) {
        print(r);
        _postOnline(r);
        await sleep();
        await db.delete("enumeratorOfflineData", //table name
            where: "id = ?",
            whereArgs: [countInt] // use whereArgs to avoid SQL injection
            );
        setState(() {});
      }
      countInt--;
    }
    if (countInt == 0) {
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "Hooray! Nailagay na online ang iyong mga natitirang tala",
        ),
      );
    }
  }

  Future sleep() {
    return new Future.delayed(const Duration(milliseconds: 1500), () => "1");
  }

  _postOnline(feedback) async {
    await GoogleSheetsApi.insert([feedback]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 100),
            color: Colors.purple,
            child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 1), () async {
                    setState(() {});

                    bool isConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (isConnected == true) {
                      print('Is connedted :)');
                      _queryOffline();
                    } else {
                      print('Not connected :(');
                    }
                  });
                },
                child: RawScrollbar(
                    thumbColor: Colors.green,
                    radius: Radius.circular(10),
                    thickness: 7,
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: Column(children: [
                          OfflineCacheList(),
                          Calendar(),
                          ActivitiesList(),
                        ]))))));
  }
}
