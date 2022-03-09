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

  String speciesPic = '';
  showStoredForm(
      BuildContext context,
      String? uuid,
      String? speciesName,
      String? commonName,
      speciesPic,
      String? enumerator,
      String? date,
      String? fishingGround,
      String? landingCenter,
      String? totalLandings,
      String? boatName,
      String? fishingGear,
      String? fishingEffort,
      String? totalBoatCatch,
      String? sampleSerialNumber,
      String? sampleWeight,
      String? weight,
      String? length) {
    ;
    var alert = AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32))),
        content: RawScrollbar(
            thumbColor: Colors.green,
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${date}"),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('I-edit',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.edit,
                                            color: Colors.green)),
                                    Text('I-delete',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)),
                                    IconButton(
                                        onPressed: () {
                                          showDeleteDialog(uuid, context);
                                        },
                                        icon: Icon(Icons.delete,
                                            color: Colors.red)),
                                  ]),
                            ]),
                        Image.asset(speciesPic),
                        Text("\n${commonName}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text("${speciesName}",
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        Text("Haba: ${length} cm     Bigat: ${weight} g"),
                        Text("\nDetalye ng Lugar",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Tinala ni: ${enumerator}"),
                        Text("Nahuli sa: ${fishingGround}"),
                        Text("Dinaong sa: ${landingCenter}"),
                        Text("Bilang ng mga dumaong: ${totalLandings}"),
                        Text("\nDetalye ng Dumaong",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Pangalan ng Bangka: ${boatName}"),
                        Text("Pangalan ng Gear na Ginamit: ${fishingGear}"),
                        Text("Tagal ng Pangingisda: ${fishingEffort} hr/s"),
                        Text("Timbang ng Nahuli: ${totalBoatCatch} kg"),
                        Text("\nDetalye ng Sample",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Sample Serial Number: ${sampleSerialNumber}"),
                        Text("Timbang ng Nahuli: ${sampleWeight} kg"),
                      ]),
                ))));
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  _queryAll() async {
    // get a reference to the database
    Database db = await DatabaseHelperOne.instance.database;
    // raw query
    List<Map> result = await db.rawQuery('SELECT * FROM enumeratorLocalData');
    // print the results
    _books = result.reversed.toList();
    //result.forEach((row) => print(row));
    // {_id: 2, name: Mary, age: 32}
  }

  Future sleep() {
    return new Future.delayed(const Duration(milliseconds: 5000), () => "1");
  }

  @override
  void initState() {
    super.initState();
    _queryAll();
  }

  List<Map> _books = [];
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
                                          'SELECT * FROM enumeratorLocalData WHERE sampleSerialNumber LIKE ? OR commonName LIKE ? OR landingCenter LIKE ? OR fishingGear LIKE ?',
                                          [
                                            '%$databaseQuery%',
                                            '%$databaseQuery%',
                                            '%$databaseQuery%',
                                            '%$databaseQuery%'
                                          ]);
                                      print(result.isEmpty);

                                      _books = result;
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
    return _books
        .map((book) => DataRow(
                onSelectChanged: (newValue) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => storedForm(
                          context: context,
                          uuid: book['uuid'],
                          speciesName: book['speciesName'],
                          commonName: book['commonName'],
                          speciesPic: book['image'],
                          enumerator: book['enumerator'],
                          date: book['date'],
                          fishingGround: book['fishingGround'],
                          landingCenter: book['landingCenter'],
                          totalLandings: book['totalLandings'],
                          boatName: book['boatName'],
                          fishingGear: book['fishingGear'],
                          fishingEffort: book['fishingEffort'],
                          totalBoatCatch: book['totalBoatCatch'],
                          sampleSerialNumber: book['sampleSerialNumber'],
                          sampleWeight: book['totalSampleWeight'],
                          weight: book['weight'],
                          length: book['length']));
                },
                cells: [
                  DataCell(Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Image.asset(book['image'].toString(), width: 60),
                        Text(book['date']),
                      ]))),
                  DataCell(Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(book['commonName'],
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('Haba: ' +
                                  book['length'] +
                                  ' cm' +
                                  '  Bigat: ' +
                                  book['weight'] +
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
                          Text('SSN: ' + book['sampleSerialNumber']),
                          Text('bigat: ' + book['totalSampleWeight'] + ' kg')
                        ],
                      ))),
                  DataCell(Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book['boatName']),
                      Text(book['fishingGear']),
                      Text(book['fishingEffort'] +
                          ' oras, ' +
                          book['totalBoatCatch'] +
                          'kg nahuli'),
                    ],
                  )),
                  DataCell(Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book['landingCenter']),
                      Text(book['fishingGround']),
                      Text('# ng dumaong:  ' + book['totalLandings'])
                    ],
                  )),
                ]))
        .toList();
  }
}
