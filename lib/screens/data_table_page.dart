import 'package:animations/animations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_taal_system/widgets/activities_list.dart';
import 'package:sqflite/sqflite.dart';
import '../backend/sqlfite_local_primary_db.dart';
import 'package:loading_animations/loading_animations.dart';

class ActivityTable extends StatefulWidget {
  @override
  _ActivityTableState createState() => _ActivityTableState();
}

class _ActivityTableState extends State<ActivityTable> {
  String argumentOne = '';
  String argumentTwo = '';

  final List<String> args = <String>[];

  // _queryDatabase(query) async {
  //   String queryText = query.text;
  //   // get a reference to the database
  //   Database db = await DatabaseHelperOne.instance.database;
  //   // raw query
  //   List<Map> result = await db.rawQuery(
  //       'SELECT * FROM enumeratorLocalData WHERE * =?', ['$queryText']);
  //   // print the results
  //   _books = result;
  //   //result.forEach((row) => print(row));
  //   // {_id: 2, name: Mary, age: 32}
  // }

  _query(argOne, argTwo) {
    if (argOne != '' && argTwo == '') {
      print('lol');
      _queryFish(argOne);
    } else if (argOne == '' && argTwo != '') {
      _queryLandingCenter(argTwo);
    } else if (argOne != '' && argTwo != '') {
      _queryBoth(argOne, argTwo);
    } else {
      _queryAll();
    }
  }

  _querySearch(String? query) async {
    //String queryText = query.text;
    Database db = await DatabaseHelperOne.instance.database;
    // raw query
    List<Map> result = await db.rawQuery(
        'SELECT * FROM enumeratorLocalData WHERE commonName LIKE ? OR landingCenter LIKE ?',
        ['%$query%']);
    // print the results
    _books = result;
  }

  _queryBoth(String filterFish, String filterPlace) async {
    // get a reference to the database
    Database db = await DatabaseHelperOne.instance.database;
    // raw query
    List<Map> result = await db.rawQuery(
        'SELECT * FROM enumeratorLocalData WHERE commonName=? and landingCenter=?',
        ['$filterFish', '$filterPlace']);
    // print the results
    _books = result;
    //result.forEach((row) => print(row));
    // {_id: 2, name: Mary, age: 32}
  }

  _queryFish(String filterFish) async {
    // get a reference to the database
    Database db = await DatabaseHelperOne.instance.database;
    // raw query
    List<Map> result = await db.rawQuery(
        'SELECT * FROM enumeratorLocalData WHERE commonName=?',
        ['$filterFish']);
    // print the results
    _books = result;
    //result.forEach((row) => print(row));
    // {_id: 2, name: Mary, age: 32}
  }

  _queryLandingCenter(String filterPlace) async {
    // get a reference to the database
    Database db = await DatabaseHelperOne.instance.database;
    // raw query
    List<Map> result = await db.rawQuery(
        'SELECT * FROM enumeratorLocalData WHERE landingCenter=?',
        ['$filterPlace']);
    // print the results

    _books = result;
    //result.forEach((row) => print(row));
    // {_id: 2, name: Mary, age: 32}
  }

  _queryAll() async {
    // get a reference to the database
    Database db = await DatabaseHelperOne.instance.database;
    // raw query
    List<Map> result = await db.rawQuery('SELECT * FROM enumeratorLocalData');
    // print the results
    _books = result;
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
        appBar: AppBar(title: Text('Profile')),
        body: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(Duration(seconds: 1), () {
                initState();
                setState(() {});
                ;
              });
            },
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
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
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      color: Colors.white,
                                      child: RawScrollbar(
                                          thumbColor: Colors.green,
                                          radius: Radius.circular(10),
                                          thickness: 7,
                                          child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(
                                                  parent:
                                                      AlwaysScrollableScrollPhysics()),
                                              child: Container(
                                                  child:
                                                      Column(children: <Widget>[
                                                SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    child: SingleChildScrollView(
                                                        physics:
                                                            BouncingScrollPhysics(
                                                                parent:
                                                                    AlwaysScrollableScrollPhysics()),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child:
                                                            _createDataTable())),
                                              ]))))))
                              : Align(
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
                                        contentPadding:
                                            EdgeInsets.only(top: 15, left: 20),
                                        hintText:
                                            "SSN, pangalan, uri ng gear, o lugar daungan",
                                        suffixIcon:
                                            // add padding to adjust icon
                                            Icon(Icons.search),
                                      ),
                                    ),
                                    // Container(
                                    //   child: Padding(
                                    //     padding:
                                    //         EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    //     child: Row(
                                    //       children: [
                                    //         Expanded(
                                    //             flex: 3,
                                    //             child: DropdownSearch<String>(
                                    //               items: [
                                    //                 "Flag-tailed glass perchlet (ning-ning)",
                                    //                 "Midas cichlid (red tilapia)",
                                    //                 "Climbing perch (martiniko)",
                                    //                 "Giant mottled eel (igat)",
                                    //                 "Manila sea catfish (kanduli)",
                                    //                 "Eendracht Land silverside (guno)",
                                    //                 "Giant trevally (maliputo)",
                                    //                 "Big-eye trevally (muslo)",
                                    //                 "Crucian carp (karpita)",
                                    //                 "Striped snakehead (dalag)",
                                    //                 "Milkfish (bangus)",
                                    //                 "Philippine catfish (hito)",
                                    //                 "Bighead catfish (hito)",
                                    //                 "Common carp (karpa)",
                                    //                 "Pipefish (kambabalo)",
                                    //                 "Tenpounder (Kanoping)",
                                    //                 "Half-barred cardinal (dangat)",
                                    //                 "Whipfin silver-biddy (balabatuhan)",
                                    //                 "Snakehead gudgeon (baculi)",
                                    //                 "Celebes goby (biyang bato)",
                                    //                 "Tank goby (biyang puti)",
                                    //                 "Bighead carp (bighead)",
                                    //                 "Quoy's garfish (siliw)",
                                    //                 "Barramundi (apahap)",
                                    //                 "Silver perch (ayungin)",
                                    //                 "Mangrove red snapper (also)",
                                    //                 "Malabar blood snapper (maya-maya)",
                                    //                 "Indo-Pacific tarpon (buan-buan)",
                                    //                 "Sharptail goby (biya)",
                                    //                 "Gossamer blenny (isdang mamay)",
                                    //                 "Nile tilapia (tilapia)",
                                    //                 "Striped catfish (pangasius)",
                                    //                 "Jaguar guapote (dugong)",
                                    //                 "Greenback mullet (Banak)",
                                    //                 "Sleepy goby (biya)",
                                    //                 "Vermiculated sailfin catfish (janitor fish)",
                                    //                 "Sardinella tawilis",
                                    //                 "Blackchin tilapia (tilapiang arroyo)",
                                    //                 "Spotted scat (kitang)",
                                    //                 "Jarbua terapon (bagaong)",
                                    //                 "Banded archerfish (kataba)",
                                    //                 "Three spot gourami (gurami)",
                                    //                 "Humpbacked cardinalfish (muang)",
                                    //                 "Feathered river-garfish (siliw)"
                                    //               ],
                                    //               mode: Mode.DIALOG,
                                    //               dropdownSearchDecoration:
                                    //                   InputDecoration(
                                    //                 hintText:
                                    //                     "Pangalan ng Isda",
                                    //                 labelStyle: TextStyle(
                                    //                     color: Colors.black,
                                    //                     fontSize: 15),
                                    //                 contentPadding:
                                    //                     EdgeInsets.fromLTRB(
                                    //                         10, 0, 0, 0),
                                    //                 border: OutlineInputBorder(
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           10),
                                    //                 ),
                                    //               ),
                                    //               onChanged: (String? value) {
                                    //                 setState(() {
                                    //                   argumentOne = value!;
                                    //                 });
                                    //                 //_changeCommonToSciName();
                                    //               },
                                    //               showSearchBox: true,
                                    //               searchFieldProps:
                                    //                   TextFieldProps(
                                    //                 decoration: InputDecoration(
                                    //                   prefixIcon: Icon(
                                    //                     Icons.search,
                                    //                   ),
                                    //                   border:
                                    //                       OutlineInputBorder(),
                                    //                   contentPadding:
                                    //                       EdgeInsets.fromLTRB(
                                    //                           12, 12, 8, 0),
                                    //                   labelText:
                                    //                       "Hanapin ang Isdang Sinukat",
                                    //                 ),
                                    //               ),
                                    //               popupTitle: Container(
                                    //                 height: 50,
                                    //                 decoration: BoxDecoration(
                                    //                   color: Color.fromARGB(
                                    //                       255, 60, 136, 63),
                                    //                   borderRadius:
                                    //                       BorderRadius.only(
                                    //                     topLeft:
                                    //                         Radius.circular(10),
                                    //                     topRight:
                                    //                         Radius.circular(10),
                                    //                   ),
                                    //                 ),
                                    //                 child: Center(
                                    //                   child: Text(
                                    //                     'Pangalan ng Isda',
                                    //                     style: TextStyle(
                                    //                       fontSize: 24,
                                    //                       fontWeight:
                                    //                           FontWeight.bold,
                                    //                       color: Colors.white,
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               popupShape:
                                    //                   RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.all(
                                    //                   Radius.circular(10),
                                    //                 ),
                                    //               ),
                                    //             )),
                                    //         Expanded(
                                    //             flex: 3,
                                    //             child: DropdownSearch<String>(
                                    //               items: [
                                    //                 "Abelo, San Nicolas",
                                    //                 "Ambulong, Tanauan City",
                                    //                 "Bugaan East, Laurel",
                                    //                 "Don Juan, Cuenca",
                                    //                 "Kinalaglagan, Mataasnakahoy",
                                    //                 "Nangkaan, Mataasnakahoy",
                                    //                 "Napapanayan, Cuenca",
                                    //                 "Poblacion, Laurel",
                                    //                 "Saimsim, Santa Teresita",
                                    //                 "Sampaloc, Talisay",
                                    //                 "Subic Ibaba, Agoncillo",
                                    //                 "Subic Ilaya, Agoncillo"
                                    //               ],
                                    //               mode: Mode.DIALOG,
                                    //               dropdownSearchDecoration:
                                    //                   InputDecoration(
                                    //                 hintText: "Lugar Daungan",
                                    //                 labelStyle: TextStyle(
                                    //                     color: Colors.black,
                                    //                     fontSize: 18),
                                    //                 contentPadding:
                                    //                     EdgeInsets.fromLTRB(
                                    //                         10, 0, 0, 0),
                                    //                 border: OutlineInputBorder(
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           10),
                                    //                 ),
                                    //               ),
                                    //               onChanged: (String? value) {
                                    //                 //_queryLandingCenter(value!);
                                    //                 setState(() {
                                    //                   argumentTwo = value!;
                                    //                 });
                                    //                 //_changeCommonToSciName();
                                    //               },
                                    //               showSearchBox: true,
                                    //               searchFieldProps:
                                    //                   TextFieldProps(
                                    //                 decoration: InputDecoration(
                                    //                   prefixIcon:
                                    //                       Icon(Icons.search),
                                    //                   border:
                                    //                       OutlineInputBorder(),
                                    //                   contentPadding:
                                    //                       EdgeInsets.fromLTRB(
                                    //                           12, 12, 8, 0),
                                    //                   labelText:
                                    //                       "Hanapin ang Isdang Sinukat",
                                    //                 ),
                                    //               ),
                                    //               popupTitle: Container(
                                    //                 height: 50,
                                    //                 decoration: BoxDecoration(
                                    //                   color: Color.fromARGB(
                                    //                       255, 60, 136, 63),
                                    //                   borderRadius:
                                    //                       BorderRadius.only(
                                    //                     topLeft:
                                    //                         Radius.circular(10),
                                    //                     topRight:
                                    //                         Radius.circular(10),
                                    //                   ),
                                    //                 ),
                                    //                 child: Center(
                                    //                   child: Text(
                                    //                     'Lugar Daungan',
                                    //                     style: TextStyle(
                                    //                       fontSize: 24,
                                    //                       fontWeight:
                                    //                           FontWeight.bold,
                                    //                       color: Colors.white,
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               popupShape:
                                    //                   RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.all(
                                    //                   Radius.circular(10),
                                    //                 ),
                                    //               ),
                                    //             )),
                                    //         Expanded(
                                    //             flex: 1,
                                    //             child: IconButton(
                                    //                 onPressed: () {
                                    //                   setState(() {
                                    //                     _query(argumentOne,
                                    //                         argumentTwo);
                                    //                     print(argumentOne);
                                    //                     print(argumentTwo);
                                    //                   });
                                    //                 },
                                    //                 icon: Icon(Icons.search,
                                    //                     color: Colors.purple,
                                    //                     size: 30)))
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                250,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        child: RawScrollbar(
                                          thumbColor: Colors.green,
                                          radius: Radius.circular(10),
                                          thickness: 10,
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
                                        ))
                                  ]));
                        }),
                //TextButton( child: Text('click meh'))
                //]),
              ),
            )) // Center)
        ); // Scaffold
  }

  DataTable _createDataTable() {
    return DataTable(
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
                  print(book['id']);
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
                              Text(book['uuid'],
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
