import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dashboard_page.dart';
import 'package:flutter_application_1/screens/data_table_page.dart';
import 'package:flutter_application_1/screens/form_page_one.dart';
import 'package:flutter_application_1/screens/manual_page.dart';
import 'package:flutter_application_1/screens/settings_page.dart';
import '../backend/sqlfite_local_primary_db.dart';
import '../widgets/stored_form.dart';

class ActivitiesList extends StatefulWidget {
  @override
  State<ActivitiesList> createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<enumeratorLocal>>(
            future: DatabaseHelperOne.instance.getEnumeratorLocal(),
            builder: (BuildContext context,
                AsyncSnapshot<List<enumeratorLocal>> snapshot) {
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
                                            .map((enumeratorLocal) {
                                          return Center(
                                              child: FractionallySizedBox(
                                                  widthFactor: 1,
                                                  child: Card(
                                                      elevation: 8,
                                                      margin:
                                                          EdgeInsets.fromLTRB(
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
                                                                      showStoredForm(
                                                                          context,
                                                                          enumeratorLocal
                                                                              .speciesName,
                                                                          enumeratorLocal
                                                                              .image,
                                                                          enumeratorLocal
                                                                              .enumerator,
                                                                          enumeratorLocal
                                                                              .date,
                                                                          enumeratorLocal
                                                                              .fishingGround,
                                                                          enumeratorLocal
                                                                              .landingCenter,
                                                                          enumeratorLocal
                                                                              .totalLandings,
                                                                          enumeratorLocal
                                                                              .boatName,
                                                                          enumeratorLocal
                                                                              .fishingGear,
                                                                          enumeratorLocal
                                                                              .fishingEffort,
                                                                          enumeratorLocal
                                                                              .totalBoatCatch,
                                                                          enumeratorLocal
                                                                              .sampleSerialNumber,
                                                                          enumeratorLocal
                                                                              .totalSampleWeight,
                                                                          enumeratorLocal
                                                                              .weight,
                                                                          enumeratorLocal
                                                                              .length);
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
                                                                                '${enumeratorLocal.speciesName}',
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 18,
                                                                                ),
                                                                              ),
                                                                              Text("Haba: ${enumeratorLocal.length} cm Bigat: ${enumeratorLocal.weight} g"),
                                                                              Text('${enumeratorLocal.landingCenter}')
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                20),
                                                                        child: Image.asset(
                                                                            '${enumeratorLocal.image}',
                                                                            width:
                                                                                80))

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
