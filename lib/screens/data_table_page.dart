import 'package:animations/animations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/widgets/activities_list.dart';
import 'package:smart_taal_system/widgets/loadingIndicator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../backend/google_sheets_api.dart';
import '../backend/sqlfite_local_primary_db.dart';
import 'package:loading_animations/loading_animations.dart';

import '../forms/output/stored_form.dart';

class ActivityTable extends StatefulWidget {
  @override
  _ActivityTableState createState() => _ActivityTableState();
}

class _ActivityTableState extends State<ActivityTable> {
  String argumentOne = '';
  String argumentTwo = '';

  final List<String> args = <String>[];

  showDeleteDialog(uuid, context) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    print(isConnected);
    if (isConnected == true) {
      showDialog(
          context: context,
          builder: (context) =>
              LoadingDialog(color: Colors.red, text: "Dinedelete"));
    } else {
      showTopSnackBar(
          context,
          CustomSnackBar.error(
            message:
                "Paalala! Kumonekta muna sa internet para makapag-delete ng tala",
          ));
    }
  }

  _queryAll() async {
    Database db = await DatabaseHelperOne.instance.database;
    List<Map> result = await db.rawQuery('SELECT * FROM enumeratorLocalData');
    _data = result.reversed.toList();
  }

  Future sleep() {
    return new Future.delayed(const Duration(milliseconds: 5000), () => "1");
  }

  @override
  void initState() {
    super.initState();
    _queryAll();
  }

  List<Map> _data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 1.07),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: //Column(children: <Widget>[
                  FutureBuilder<List<enumeratorLocal>>(
                      future: DatabaseHelperOne.instance.getEnumeratorLocal(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<enumeratorLocal>> snapshot) {
                        if (!snapshot.hasData) {
                          sleep();
                          return LoadingFlipping.circle(
                            borderColor: Colors.cyan,
                            borderSize: 3.0,
                            size: 30.0,
                            backgroundColor: Colors.cyanAccent,
                            duration: Duration(milliseconds: 500),
                          );
                        }
                        var databaseQuery;
                        return snapshot.data!.isEmpty
                            ? RefreshIndicator(
                                onRefresh: () {
                                  return Future.delayed(Duration(seconds: 1),
                                      () {
                                    setState(() {});
                                    ;
                                  });
                                },
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('MAGTALA NG AKTIBIDAD',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25)),
                                        Text(''),
                                        Row(children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 45, right: 15),
                                            child: Icon(
                                                Icons.do_not_disturb_alt,
                                                size: 40,
                                                color: Colors.red),
                                          ),
                                          Text(
                                              'Wala ka pang tala para sa araw na ito.\nPindutin ang kulay berdeng butones\nsa ilalim para magsimula.',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.purple,
                                                  fontSize: 15)),
                                        ]),
                                        Row(children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 45, right: 15),
                                            child: Icon(Icons.refresh,
                                                size: 40, color: Colors.blue),
                                          ),
                                          Text(
                                              '\nKung may natala ka na pero di pa\nlumalabas, mangyaring i-refresh ang\npahina sa pamamagitan ng paghila\nnito pababa.',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.purple,
                                                  fontSize: 15)),
                                        ]),
                                      ],
                                    )))
                            : Container(
                                alignment: Alignment.topCenter,
                                child: Column(children: [
                                  TextFormField(
                                    controller: databaseQuery,
                                    onChanged: (String? databaseQuery) async {
                                      Database db = await DatabaseHelperOne
                                          .instance.database;
                                      List<Map> result = await db.rawQuery(
                                          'SELECT * FROM enumeratorLocalData WHERE sampleSerialNumber LIKE ? OR commonName LIKE ? OR speciesName LIKE ? OR landingCenter LIKE ? OR fishingGear LIKE ?',
                                          [
                                            '%$databaseQuery%',
                                            '%$databaseQuery%',
                                            '%$databaseQuery%',
                                            '%$databaseQuery%',
                                            '%$databaseQuery%'
                                          ]);
                                      print(result.isEmpty);

                                      _data = result;
                                      print(result);
                                      setState(() {});
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 30, bottom: 20, left: 20),
                                      hintText:
                                          "SSN, pangalan, uri ng gear, o lugar daungan",
                                      suffixIcon:
                                          // add padding to adjust icon
                                          Icon(Icons.search),
                                    ),
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              250,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: RawScrollbar(
                                          thumbColor: Colors.green,
                                          radius: Radius.circular(10),
                                          thickness: 10,
                                          child: RefreshIndicator(
                                            onRefresh: () {
                                              return Future.delayed(
                                                  Duration(seconds: 1), () {
                                                setState(() {});
                                                ;
                                              });
                                            },
                                            child: SingleChildScrollView(
                                                physics: BouncingScrollPhysics(
                                                    parent:
                                                        AlwaysScrollableScrollPhysics()),
                                                scrollDirection: Axis.vertical,
                                                child: SingleChildScrollView(
                                                    physics: BouncingScrollPhysics(
                                                        parent:
                                                            AlwaysScrollableScrollPhysics()),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: _createDataTable())),
                                          )))
                                ]));
                      }),
            ),
          ),
        ) // Center)
        ); // Scaffold
  }

  DataTable _createDataTable() {
    return DataTable(
        sortAscending: false,
        showCheckboxColumn: false,
        columnSpacing: 10,
        headingRowHeight: 60,
        headingTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.purple),
        dataTextStyle: TextStyle(color: Colors.black),
        dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
        dataRowHeight: 79,
        columns: _createColumns(),
        rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
          label: Center(child: Text('Petsa', textAlign: TextAlign.center))),
      DataColumn(
          label: Center(
              child: Text('Mga Isdang Nahuli', textAlign: TextAlign.center))),
      DataColumn(
          label: Center(child: Text('Sample', textAlign: TextAlign.center))),
      DataColumn(
          label: Center(child: Text('Bangka', textAlign: TextAlign.center))),
      DataColumn(
          label: Center(child: Text('Lugar', textAlign: TextAlign.center))),
    ];
  }

  List<DataRow> _createRows() {
    return _data
        .map((data) => DataRow(
                onSelectChanged: (newValue) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => storedForm(
                          context: context,
                          uuid: data['uuid'],
                          speciesName: data['speciesName'],
                          commonName: data['commonName'],
                          speciesPic: data['image'],
                          enumerator: data['enumerator'],
                          date: data['date'],
                          fishingGround: data['fishingGround'],
                          landingCenter: data['landingCenter'],
                          totalLandings: data['totalLandings'],
                          boatName: data['boatName'],
                          fishingGear: data['fishingGear'],
                          fishingEffort: data['fishingEffort'],
                          totalBoatCatch: data['totalBoatCatch'],
                          sampleSerialNumber: data['sampleSerialNumber'],
                          sampleWeight: data['totalSampleWeight'],
                          weight: data['weight'],
                          length: data['length']));
                },
                cells: [
                  DataCell(Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Image.asset(data['image'].toString(), width: 60),
                        Text(data['date']),
                      ]))),
                  DataCell(Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['commonName'],
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('Haba: ' +
                                  data['length'] +
                                  ' cm' +
                                  '  Bigat: ' +
                                  data['weight'] +
                                  ' g'),
                            ],
                          ))
                    ],
                  )),
                  DataCell(Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SSN: ' + data['sampleSerialNumber']),
                          Text('bigat: ' + data['totalSampleWeight'] + ' kg')
                        ],
                      ))),
                  DataCell(Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['boatName']),
                      Text(data['fishingGear']),
                      Text(data['fishingEffort'] +
                          ' oras, ' +
                          data['totalBoatCatch'] +
                          'kg nahuli'),
                    ],
                  )),
                  DataCell(Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['landingCenter']),
                      Text(data['fishingGround']),
                      Text('# ng dumaong:  ' + data['totalLandings'])
                    ],
                  )),
                ]))
        .toList();
  }
}
