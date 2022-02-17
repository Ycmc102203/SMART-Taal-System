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
    var enumeratorLocalData =
        await db.query('enumeratorLocalData', orderBy: 'date');
    List<enumeratorLocal> enumeratorLocalList = enumeratorLocalData.isNotEmpty
        ? enumeratorLocalData.map((c) => enumeratorLocal.fromMap(c)).toList()
        : [];
    return enumeratorLocalList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: //Column(children: <Widget>[
            FutureBuilder<List<enumeratorLocal>>(
                future: DatabaseHelperOne.instance.getEnumeratorLocal(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<enumeratorLocal>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('Loading...'));
                  }
                  return snapshot.data!.isEmpty
                      ? Center(
                          child: Text('MAGTALA NG AKTIBIDAD',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30)),
                        )
                      : ListView(
                          reverse: true,
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          shrinkWrap: true,
                          children: snapshot.data!.map((enumeratorLocal) {
                            return Center(
                                child: FractionallySizedBox(
                                    widthFactor: 1,
                                    child: Card(
                                        elevation: 8,
                                        margin:
                                            EdgeInsets.fromLTRB(15, 0, 15, 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                            height: 75,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                      onTap: () {},
                                                      leading: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8),
                                                        child: Wrap(
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '${enumeratorLocal.speciesName}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                                Text(
                                                                    "Haba: ${enumeratorLocal.length} cm Bigat: ${enumeratorLocal.weight} g"),
                                                                Text(
                                                                    '${enumeratorLocal.landingCenter}')
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      trailing: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20),
                                                          child: Image.asset(
                                                              '${enumeratorLocal.image}',
                                                              width: 80))

                                                      // trailing: Icon(Icons.wifi,
                                                      //     color: Colors.green)
                                                      //     : Icons.wifi_off,
                                                      // color: completed ? Colors.green : Colors.red)
                                                      ),
                                                ])))));
                          }).toList(),
                        );
                }),
        //TextButton( child: Text('click meh'))
        //]),
      ), // Center
    ); // Scaffold
  }
}
