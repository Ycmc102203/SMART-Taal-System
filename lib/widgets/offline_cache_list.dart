import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_taal_system/backend/sqlfite_local_offline_cache.dart';
import '../backend/sqlfite_local_primary_db.dart';
import '../forms/output/stored_form.dart';

class OfflineCacheList extends StatefulWidget {
  @override
  State<OfflineCacheList> createState() => _OfflineCacheListState();
}

class _OfflineCacheListState extends State<OfflineCacheList> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<enumeratorOffline>>(
            future: DatabaseHelperTwo.instance.getEnumeratorOffline(),
            builder: (BuildContext context,
                AsyncSnapshot<List<enumeratorOffline>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(child: child, scale: animation);
                  },
                  child: snapshot.data!.isEmpty
                      ? Container()
                      : Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                          child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Colors.white, width: 5)),
                              child: Container(
                                  width: double.infinity,
                                  child: Column(children: [
                                    Container(
                                        color: Colors.red,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                8,
                                        child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "Mga Hindi pa Uploaded",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 24)),
                                                        Text(
                                                            "I-refresh ang page pag may internet na\npara matala online ang mga natitira",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                fontSize: 14)),
                                                      ]),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      child: Icon(
                                                          Icons.wifi_off,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          size: 50))
                                                ]))),
                                    Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                          stops: [
                                            0,
                                            0.50,
                                            1.0,
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color.fromARGB(149, 255, 255, 255),
                                            Color.fromARGB(255, 255, 140, 140),
                                            Color.fromARGB(149, 255, 255, 255),
                                          ],
                                        )),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                100,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [])),
                                    Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            const BoxShadow(
                                              color:
                                                  Color.fromARGB(129, 0, 0, 0),
                                            ),
                                            const BoxShadow(
                                              color: Colors.white,
                                              spreadRadius: -5.0,
                                              blurRadius: 8.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 20),
                                        child: RawScrollbar(
                                          thumbColor: Colors.green,
                                          radius: Radius.circular(10),
                                          thickness: 15,
                                          child: RefreshIndicator(
                                              onRefresh: () {
                                                return Future.delayed(
                                                    Duration(seconds: 1), () {
                                                  setState(() {});
                                                });
                                              },
                                              child: SingleChildScrollView(
                                                  physics: BouncingScrollPhysics(
                                                      parent:
                                                          AlwaysScrollableScrollPhysics()),
                                                  child: ListView(
                                                    reverse: true,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    children: snapshot.data!.map(
                                                        (enumeratorOffline) {
                                                      return Center(
                                                          child:
                                                              FractionallySizedBox(
                                                                  widthFactor:
                                                                      1,
                                                                  child: Card(
                                                                      elevation:
                                                                          5,
                                                                      margin: EdgeInsets
                                                                          .fromLTRB(
                                                                              15,
                                                                              0,
                                                                              15,
                                                                              5),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      child: Container(
                                                                          height: 85,
                                                                          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                            ListTile(
                                                                                onTap: () {
                                                                                  showDialog(context: context, builder: (BuildContext context) => storedForm(context: context, uuid: enumeratorOffline.uuid, speciesName: enumeratorOffline.speciesName, commonName: enumeratorOffline.commonName, speciesPic: enumeratorOffline.image, enumerator: enumeratorOffline.enumerator, date: enumeratorOffline.date, fishingGround: enumeratorOffline.fishingGround, landingCenter: enumeratorOffline.landingCenter, totalLandings: enumeratorOffline.totalLandings, boatName: enumeratorOffline.boatName, fishingGear: enumeratorOffline.fishingGear, fishingEffort: enumeratorOffline.fishingEffort, totalBoatCatch: enumeratorOffline.totalBoatCatch, sampleSerialNumber: enumeratorOffline.sampleSerialNumber, sampleWeight: enumeratorOffline.totalSampleWeight, weight: enumeratorOffline.weight, length: enumeratorOffline.length));
                                                                                },
                                                                                leading: Padding(
                                                                                  padding: EdgeInsets.only(top: 8),
                                                                                  child: Wrap(
                                                                                    children: [
                                                                                      Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            "${enumeratorOffline.date}",
                                                                                            style: TextStyle(fontSize: 10),
                                                                                          ),
                                                                                          Text(
                                                                                            '${enumeratorOffline.speciesName}',
                                                                                            style: TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontSize: 18,
                                                                                            ),
                                                                                          ),
                                                                                          Text("Haba: ${enumeratorOffline.length} cm Bigat: ${enumeratorOffline.weight} g"),
                                                                                          Text('${enumeratorOffline.landingCenter}')
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                trailing: Padding(padding: EdgeInsets.only(top: 20), child: Image.asset('${enumeratorOffline.image}', width: 80))),
                                                                          ])))));
                                                    }).toList(),
                                                  ))),
                                        ))
                                  ])))));
            }));
  }
}
