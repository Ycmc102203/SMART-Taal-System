import 'package:flutter/material.dart';
import 'package:smart_taal_system/screens/dashboard_page.dart';
import 'package:smart_taal_system/screens/data_table_page.dart';
import 'package:smart_taal_system/forms/form_place_page.dart';
import 'package:smart_taal_system/screens/manual_page.dart';
import 'package:smart_taal_system/screens/settings_page.dart';
import 'package:sqflite/sqflite.dart';
import '../backend/sqlfite_local_primary_db.dart';
import '../backend/sqlfite_local_secondary_db.dart';
import '../widgets/stored_form.dart';

class DaysList extends StatefulWidget {
  @override
  State<DaysList> createState() => _DaysListState();
}

class _DaysListState extends State<DaysList> {
  var dateSelected;
  _query() async {
    // get a reference to the database
    Database db = await DatabaseHelperOne.instance.database;
    // raw query
    List<Map> result = await db.rawQuery(
        'SELECT * FROM enumeratorLocalData WHERE date=?', ['$dateSelected']);
    // print the results
    result.forEach((row) => print(row));
    // {_id: 2, name: Mary, age: 32}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<enumeratorDays>>(
            future: DatabaseHelperTwo.instance.getenumeratorDays(),
            builder: (BuildContext context,
                AsyncSnapshot<List<enumeratorDays>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? RefreshIndicator(
                      child: RawScrollbar(
                          child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Center(
                                  child: Column(children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0,
                                        MediaQuery.of(context).size.width / 1.8,
                                        0,
                                        0),
                                    child: Text('MAGTALA NG BAGONG AKTIBIDAD',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                176, 255, 255, 255),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)))
                              ])))),
                      onRefresh: () {
                        return Future.delayed(Duration(seconds: 1), () {
                          setState(() {});
                          ;
                        });
                      },
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Container(
                          child: Column(children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 40, 15, 0),
                            child: Container(
                                width: MediaQuery.of(context).size.width / 1.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15)),
                                  color: Color.fromARGB(225, 255, 255, 255),
                                ),
                                height: MediaQuery.of(context).size.height / 15,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Mga Natalang Isda         ",
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24)),
                                      Icon(Icons.checklist,
                                          color: Colors.purple)
                                    ]))),
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          margin: EdgeInsets.fromLTRB(10, 0, 15, 0),
                          width: MediaQuery.of(context).size.width / 1.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                              border: Border.all(
                                  color: Color.fromARGB(225, 255, 255, 255),
                                  width: 5)),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: RawScrollbar(
                              thumbColor: Colors.white,
                              radius: Radius.circular(10),
                              thickness: 7,
                              child: RefreshIndicator(
                                  onRefresh: () {
                                    return Future.delayed(Duration(seconds: 1),
                                        () {
                                      setState(() {});
                                    });
                                  },
                                  child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(
                                          parent:
                                              AlwaysScrollableScrollPhysics()),
                                      child: ListView(
                                        reverse: true,
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        children: snapshot.data!
                                            .map((enumeratorDays) {
                                          return Center(
                                              child: FractionallySizedBox(
                                                  widthFactor: 1,
                                                  child: Card(
                                                      elevation: 8,
                                                      margin: EdgeInsets
                                                          .fromLTRB(
                                                              15, 0, 15, 10),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      child: Container(
                                                          height: 75,
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                ListTile(
                                                                    onTap: () {
                                                                      dateSelected =
                                                                          enumeratorDays
                                                                              .date;
                                                                      _query();
                                                                      // showStoredForm(
                                                                      //     context,
                                                                      //     enumeratorDays
                                                                      //         .speciesName,
                                                                      //     enumeratorDays
                                                                      //         .image,
                                                                      //     enumeratorDays
                                                                      //         .enumerator,
                                                                      //     enumeratorDays
                                                                      //         .date,
                                                                      //     enumeratorDays
                                                                      //         .fishingGround,
                                                                      //     enumeratorDays
                                                                      //         .landingCenter,
                                                                      //     enumeratorDays
                                                                      //         .totalLandings,
                                                                      //     enumeratorDays
                                                                      //         .boatName,
                                                                      //     enumeratorDays
                                                                      //         .fishingGear,
                                                                      //     enumeratorDays
                                                                      //         .fishingEffort,
                                                                      //     enumeratorDays
                                                                      //         .totalBoatCatch,
                                                                      //     enumeratorDays
                                                                      //         .sampleSerialNumber,
                                                                      //     enumeratorDays
                                                                      //         .totalSampleWeight,
                                                                      //     enumeratorDays
                                                                      //         .weight,
                                                                      //     enumeratorDays
                                                                      //         .length);
                                                                    },
                                                                    leading:
                                                                        Padding(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                      child:
                                                                          Wrap(
                                                                        children: [
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                '${enumeratorDays.date}',
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 18,
                                                                                ),
                                                                              ),
                                                                              //Text("Haba: ${enumeratorDays.length} cm Bigat: ${enumeratorDays.weight} g"),
                                                                              Text('${enumeratorDays.landingCenter}')
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: Padding(
                                                                        padding: EdgeInsets.only(top: 20),
                                                                        child:
                                                                            // Image.asset(
                                                                            //     '${enumeratorDays.image}',
                                                                            //     width:
                                                                            //         80)
                                                                            Text('lol'))

                                                                    // trailing: Icon(Icons.wifi,
                                                                    //     color: Colors.green)
                                                                    //     : Icons.wifi_off,
                                                                    // color: completed ? Colors.green : Colors.red)
                                                                    ),
                                                              ])))));
                                        }).toList(),
                                      )))),
                        )
                      ])));
            }));
  }
}
