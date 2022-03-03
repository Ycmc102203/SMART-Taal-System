import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/backend/google_sheets_api.dart';
import 'package:smart_taal_system/backend/sqlfite_local_offline_cache.dart';
import 'package:smart_taal_system/widgets/activities_list.dart';
import 'package:smart_taal_system/widgets/calendar.dart';
import 'package:smart_taal_system/widgets/offline_cache_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../backend/sqlfite_local_primary_db.dart';

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
      List<Map<String, dynamic>> results = await db.rawQuery(
          'SELECT * FROM enumeratorOfflineData WHERE id=?', ['$countInt']);
      for (var r in results) {
        _postOnline(r);
        await sleep();
        await db.delete("enumeratorOfflineData", //table name
            where: "id = ?",
            whereArgs: [countInt] // use whereArgs to avoid SQL injection
            );
        await sleep();
        await DatabaseHelperOne.instance.add(enumeratorLocal(
            uuid: r['uuid'],
            date: r['date'],
            enumerator: r['enumerator'],
            landingCenter: r['landingCenter'],
            fishingGround: r['fishingGround'],
            totalLandings: r['totalLandings'],
            boatName: r['boatName'],
            fishingGear: r['fishingGear'],
            fishingEffort: r['fishingEffort'],
            totalBoatCatch: r['totalBoatCatch'],
            sampleSerialNumber: r['sampleSerialNumber'],
            totalSampleWeight: r['totalSampleWeight'],
            speciesName: r['speciesName'],
            commonName: r['commonName'],
            length: r['length'],
            weight: r['weight'],
            image: r['image']));
        await sleep();
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
    return new Future.delayed(const Duration(milliseconds: 500), () => "1");
  }

  _postOnline(feedback) async {
    await GoogleSheetsApi.insert([feedback]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 13),
            color: Colors.purple,
            child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 1), () async {
                    setState(() {});
                    bool isConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (isConnected == true) {
                      print('Is connected :)');
                      _queryOffline();
                    } else {
                      print('Not connected :(');
                      showTopSnackBar(
                        context,
                        CustomSnackBar.error(
                          message:
                              "Wala ka paring internet :( Kailangan ng internet para mag-sync ang datos sa database.",
                        ),
                      );
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
                        child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Column(children: [
                              OfflineCacheList(),
                              ActivitiesList(),
                              Calendar(),
                            ])))))));
  }
}
