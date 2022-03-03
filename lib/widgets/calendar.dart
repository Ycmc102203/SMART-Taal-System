import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_taal_system/forms/output/stored_form_for_date.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_calendar/table_calendar.dart';
import '../backend/sqlfite_local_primary_db.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  var colorProfile;
  DateTime? _selectedDay;
  DateTime? _focusedDay;
  String _queryDate = '';
  String? speciesOnDate;
  int? listLength;

  void _showTallyOfTheDay() {
    print(_queryDate);
    _query();
  }

  Future<List<enumeratorLocal>> _query() async {
    // get a reference to the database
    Database db = await DatabaseHelperOne.instance.database;
    // raw query
    var result = await db.rawQuery(
        'SELECT * FROM enumeratorLocalData WHERE date=?', ['$_queryDate']);
    // print the results
    List<enumeratorLocal> enumeratorLocalList = result.isNotEmpty
        ? result.map((c) => enumeratorLocal.fromMap(c)).toList()
        : [];
    return enumeratorLocalList;
    // {_id: 2, name: Mary, age: 32}
  }

  void showModal() {
    showStoredFormForDate(context, _query(), _queryDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 20),
        width: double.infinity,
        child: Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.white, width: 5)),
            child: Column(children: [
              Container(
                  color: Colors.purple,
                  height: MediaQuery.of(context).size.height / 10,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Kalendaryo ng mga Tala",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24)),
                            Icon(Icons.date_range,
                                color: Color.fromARGB(255, 255, 255, 255))
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
                      Color.fromARGB(150, 155, 39, 176),
                      Color.fromARGB(150, 76, 175, 79),
                      Color.fromARGB(150, 155, 39, 176),
                    ],
                  )),
                  height: MediaQuery.of(context).size.height / 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [])),
              TableCalendar(
                calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    )),
                daysOfWeekHeight: 16.0,
                rowHeight: 50,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _queryDate = DateFormat('yyyy-MM-dd').format(focusedDay);
                    showModal(); // update `_focusedDay` here as well
                  });
                },
              ),

              // Container(
              //     child: ListView.builder(
              //         padding: const EdgeInsets.only(top: 0, bottom: 5),
              //         itemCount: species.length,
              //         itemBuilder: (BuildContext context, int index) {
              //           return Card(
              //               elevation: 4,
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(8)),
              //               child: ListTile(
              //                 leading: Padding(
              //                   padding: EdgeInsets.only(top: 10),
              //                   child: Column(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.start,
              //                     crossAxisAlignment:
              //                         CrossAxisAlignment.start,
              //                     children: [
              //                       Text(
              //                         '${species[index]}',
              //                         style: TextStyle(
              //                           fontWeight: FontWeight.bold,
              //                           fontSize: 15,
              //                         ),
              //                       ),
              //                       Text(
              //                           "Haba: ${length[index]} cm     Bigat: ${weight[index]} g")
              //                     ],
              //                   ),
              //                 ),
              //                 trailing:
              //                     Image.asset('${pic[index]}', width: 60),
              //               ));
              //         }))
            ])));
  }
}
