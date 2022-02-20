import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
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
                                      Text("Mga Naitalang Isda",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24)),
                                      Text("i-filter: ",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 15))
                                    ]),
                                FaIcon(FontAwesomeIcons.fish,
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
                                          ? Center(
                                              child: Text(
                                                  'MAGTALA NG AKTIBIDAD',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30)),
                                            )
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
                                                                            showStoredForm(
                                                                                context,
                                                                                enumeratorLocal.speciesName,
                                                                                enumeratorLocal.commonName,
                                                                                enumeratorLocal.image,
                                                                                enumeratorLocal.enumerator,
                                                                                enumeratorLocal.date,
                                                                                enumeratorLocal.fishingGround,
                                                                                enumeratorLocal.landingCenter,
                                                                                enumeratorLocal.totalLandings,
                                                                                enumeratorLocal.boatName,
                                                                                enumeratorLocal.fishingGear,
                                                                                enumeratorLocal.fishingEffort,
                                                                                enumeratorLocal.totalBoatCatch,
                                                                                enumeratorLocal.sampleSerialNumber,
                                                                                enumeratorLocal.totalSampleWeight,
                                                                                enumeratorLocal.weight,
                                                                                enumeratorLocal.length);
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
