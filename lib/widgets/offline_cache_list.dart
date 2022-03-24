import 'package:flutter/material.dart';
import 'package:smart_taal_system/backend/sqlfite_local_offline_cache.dart';
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
                                        height: 90,
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
                                                            "Mga Hindi Na-upload",
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
                                        color: Colors.white,
                                        height: 5,
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
                                                    children: snapshot.data!
                                                        .map((enumeratorLocal) {
                                                      return Center(
                                                          child: Container(
                                                        height: 100,
                                                        child: Card(
                                                            elevation: 5,
                                                            margin: EdgeInsets
                                                                .fromLTRB(15, 0,
                                                                    15, 10),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext context) => storedForm(
                                                                        context:
                                                                            context,
                                                                        uuid: enumeratorLocal
                                                                            .uuid,
                                                                        speciesName: enumeratorLocal
                                                                            .speciesName,
                                                                        commonName: enumeratorLocal
                                                                            .commonName,
                                                                        speciesPic:
                                                                            enumeratorLocal
                                                                                .image,
                                                                        enumerator:
                                                                            enumeratorLocal
                                                                                .enumerator,
                                                                        date: enumeratorLocal
                                                                            .date,
                                                                        fishingGround:
                                                                            enumeratorLocal
                                                                                .fishingGround,
                                                                        landingCenter:
                                                                            enumeratorLocal
                                                                                .landingCenter,
                                                                        totalLandings:
                                                                            enumeratorLocal
                                                                                .totalLandings,
                                                                        boatName:
                                                                            enumeratorLocal
                                                                                .boatName,
                                                                        fishingGear:
                                                                            enumeratorLocal
                                                                                .fishingGear,
                                                                        fishingEffort:
                                                                            enumeratorLocal
                                                                                .fishingEffort,
                                                                        totalBoatCatch:
                                                                            enumeratorLocal
                                                                                .totalBoatCatch,
                                                                        sampleSerialNumber:
                                                                            enumeratorLocal
                                                                                .sampleSerialNumber,
                                                                        sampleWeight:
                                                                            enumeratorLocal
                                                                                .totalSampleWeight,
                                                                        weight: enumeratorLocal
                                                                            .weight,
                                                                        length:
                                                                            enumeratorLocal.length));
                                                              },
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          10,
                                                                          5,
                                                                          10,
                                                                          10),
                                                                  child:
                                                                      SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        60,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              10,
                                                                          child:
                                                                              Wrap(
                                                                            children: [
                                                                              Text(
                                                                                '${enumeratorLocal.commonName}',
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.w800,
                                                                                  fontSize: 15,
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text("Haba: ${enumeratorLocal.length} cm | Bigat: ${enumeratorLocal.weight} g"),
                                                                                  Text('${enumeratorLocal.landingCenter}')
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                            flex:
                                                                                3,
                                                                            child:
                                                                                Image.asset('${enumeratorLocal.image}', width: 80))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )),
                                                      ));
                                                    }).toList(),
                                                  ))),
                                        ))
                                  ])))));
            }));
  }
}
