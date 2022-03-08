import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/widgets/loadingIndicator.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../backend/sqlfite_local_primary_db.dart';
import '../backend/google_sheets_api.dart';
import '../forms/output/stored_form.dart';
import '../screens/colors_list.dart';

class ActivitiesList extends StatefulWidget {
  final refreshList;
  ActivitiesList({this.refreshList});
  @override
  State<ActivitiesList> createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 20),
        height: 440,
        child: Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.white, width: 5)),
            child: Container(
                width: double.infinity,
                child: Column(children: [
                  Container(
                      color: Colors.purple,
                      height: MediaQuery.of(context).size.height / 10,
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Mga Naitalang Isda Ngayon",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25))
                                    ]),
                                FaIcon(FontAwesomeIcons.fish,
                                    color: Color.fromARGB(255, 255, 255, 255))
                              ]))),
                  Container(
                      height: 5,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [])),
                  Container(
                      height: 350,
                      decoration: BoxDecoration(
                        boxShadow: [
                          const BoxShadow(
                            color: Color.fromARGB(129, 0, 0, 0),
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
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: RawScrollbar(
                        thumbColor: Colors.green,
                        radius: Radius.circular(10),
                        thickness: 15,
                        child: RefreshIndicator(
                            onRefresh: () {
                              return Future.delayed(Duration(seconds: 1), () {
                                setState(() {});
                                widget.refreshList;
                              });
                            },
                            child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                child: FutureBuilder<List<enumeratorLocal>>(
                                    future: DatabaseHelperOne.instance
                                        .getEnumeratorLocal(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<enumeratorLocal>>
                                            snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                            child: Text('Loading...'));
                                      }
                                      return snapshot.data!.isEmpty
                                          ? Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text('MAGTALA NG AKTIBIDAD',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.purple,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25)),
                                                  Text(''),
                                                  Row(children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 45, right: 15),
                                                      child: Icon(
                                                          Icons
                                                              .do_not_disturb_alt,
                                                          size: 40,
                                                          color: Colors.red),
                                                    ),
                                                    Text(
                                                        'Wala ka pang tala para sa araw na ito.\nPindutin ang kulay berdeng butones\nsa ilalim para magsimula.',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.purple,
                                                            fontSize: 15)),
                                                  ]),
                                                  Row(children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 45, right: 15),
                                                      child: Icon(Icons.refresh,
                                                          size: 40,
                                                          color: Colors.blue),
                                                    ),
                                                    Text(
                                                        '\nKung may natala ka na pero di pa\nlumalabas, mangyaring i-refresh ang\npahina sa pamamagitan ng paghila\nnito pababa.',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.purple,
                                                            fontSize: 15)),
                                                  ]),
                                                ],
                                              ))
                                          : ListView(
                                              reverse: true,
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              children: snapshot.data!
                                                  .map((enumeratorLocal) {
                                                return Center(
                                                    child: FractionallySizedBox(
                                                        widthFactor: 1,
                                                        child: Card(
                                                            elevation: 5,
                                                            margin: EdgeInsets
                                                                .fromLTRB(15, 0,
                                                                    15, 5),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Container(
                                                                height: 85,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      ListTile(
                                                                          onTap:
                                                                              () {
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) => storedForm(context: context, uuid: enumeratorLocal.uuid, speciesName: enumeratorLocal.speciesName, commonName: enumeratorLocal.commonName, speciesPic: enumeratorLocal.image, enumerator: enumeratorLocal.enumerator, date: enumeratorLocal.date, fishingGround: enumeratorLocal.fishingGround, landingCenter: enumeratorLocal.landingCenter, totalLandings: enumeratorLocal.totalLandings, boatName: enumeratorLocal.boatName, fishingGear: enumeratorLocal.fishingGear, fishingEffort: enumeratorLocal.fishingEffort, totalBoatCatch: enumeratorLocal.totalBoatCatch, sampleSerialNumber: enumeratorLocal.sampleSerialNumber, sampleWeight: enumeratorLocal.totalSampleWeight, weight: enumeratorLocal.weight, length: enumeratorLocal.length));
                                                                          },
                                                                          leading:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: 8),
                                                                            child:
                                                                                Wrap(
                                                                              children: [
                                                                                Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "${enumeratorLocal.date}",
                                                                                      style: TextStyle(fontSize: 10),
                                                                                    ),
                                                                                    Text(
                                                                                      '${enumeratorLocal.commonName}',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 17,
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
                                                                              padding: EdgeInsets.only(top: 20),
                                                                              child: Image.asset('${enumeratorLocal.image}', width: 80))),
                                                                    ])))));
                                              }).toList(),
                                            );
                                    }))),
                      ))
                ]))));
  }
}
