// import 'package:flutter/material.dart';
// import 'package:smart_taal_system/backend/model.dart';
// import 'package:smart_taal_system/backend/sqlfite_local_db.dart';
// import 'dashboard_page.dart';

// class ActivityTable extends StatefulWidget {
//   @override
//   _ActivityTableState createState() => _ActivityTableState();
//   final double coverHeight = 125;
//   final double profileHeight = 45;
// }

// class _ActivityTableState extends State<ActivityTable> {
//   // late List<EnumeratorData> enumeratorData;
//   // bool loading = true;
//   // Future fetchAllData()async{
//   //   dataList = await
//   // }
//   List enumeratorDataList;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.purple,
//       body: Center(child: buildDataTable()), // Center
//     ); // Scaffold
//   }

//   Widget buildDataTable() {
//     final columns = [
//       'id',
//       'date',
//       'enumerator',
//       'landingCenter',
//       'fishingGround',
//       'totalLandings',
//       'boatName',
//       'fishingGear',
//       'fishingEffort',
//       'totalBoatCatch',
//       'sampleSerialNumber',
//       'totalSampleWeight',
//       'speciesName',
//       'length',
//       'weight',
//       'image',
//     ];

//     return DataTable(
//         columns: getColumns(columns), rows: getRows(enumeratorData));
//   }

//   List<DataColumn> getColumns(List<String> columns) => columns
//       .map((String column) => DataColumn(
//             label: Text(column),
//           ))
//       .toList();
//   List<DataRow> getRows(List<enumeratorLocal> enumeratorData) =>
//       enumeratorData.map((enumeratorLocal enumeratorData) {
//         final cells = [
//           enumeratorData.id,
//           enumeratorData.date,
//           enumeratorData.enumerator,
//           enumeratorData.landingCenter,
//           enumeratorData.fishingGround,
//           enumeratorData.totalLandings,
//           enumeratorData.boatName,
//           enumeratorData.fishingGear,
//           enumeratorData.fishingEffort,
//           enumeratorData.totalBoatCatch,
//           enumeratorData.sampleSerialNumber,
//           enumeratorData.totalSampleWeight,
//           enumeratorData.speciesName,
//           enumeratorData.length,
//           enumeratorData.weight,
//           enumeratorData.image
//         ];
//         return DataRow(cells: getCells(cells));
//       }).toList();
//   List<DataCell> getCells(List<dynamic> cells) =>
//       cells.map((data) => DataCell(Text('$data'))).toList();
// }

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../backend/sqlfite_local_primary_db.dart';

class ActivityTable extends StatefulWidget {
  @override
  _ActivityTableState createState() => _ActivityTableState();
}

class _ActivityTableState extends State<ActivityTable> {
  _query() async {
    // get a reference to the database
    Database db = await DatabaseHelperOne.instance.database;
    // raw query
    List<Map> result = await db
        .rawQuery('SELECT * FROM enumeratorLocalData WHERE length=?', ['24']);
    // print the results
    result.forEach((row) => print(row));
    // {_id: 2, name: Mary, age: 32}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: //Column(children: <Widget>[
            Text('ActivityTable Screen',
                style: TextStyle(color: Colors.white, fontSize: 40)),
        //TextButton( child: Text('click meh'))
        //]),
      ), // Center
    ); // Scaffold
  }
}
