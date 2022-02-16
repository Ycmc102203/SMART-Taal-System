import 'package:flutter/material.dart';
import 'package:smart_taal_system/forms/form_specimen_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';

class NewActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
  void _showAddSpeciesModal() {
    Navigator.of(context).pop();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(35), topLeft: Radius.circular(35))),
        enableDrag: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => NewSpecies(
              addSpecies: _addSpecies,
              passedDate: dateTime,
              passedEnumerator: enumeratorController.text,
              passedFishingGround: fishingGroundController.text,
              passedLandingCenter: landingCenterController.text,
              passedTotalLandings: totalLandingsController.text,
              passedBoatName: boatNameController.text,
              passedFishingGear: fishingGearController.text,
              passedFishingEffort: fishingEffortController.text,
              passedTotalBoatCatch: totalBoatCatchController.text,
              passedSampleSerialNumber: sampleSerialNumberController.text,
              passedTotalSampleWeight: totalSampleWeightController.text,
            ));
  }

  void _addSpecies(String species) {
    setState(() {});
  }

  TextEditingController enumeratorController = TextEditingController();
  TextEditingController landingCenterController = TextEditingController();
  TextEditingController fishingGroundController = TextEditingController();
  TextEditingController totalLandingsController = TextEditingController();
  TextEditingController boatNameController = TextEditingController();
  TextEditingController fishingGearController = TextEditingController();
  TextEditingController fishingEffortController = TextEditingController();
  TextEditingController totalBoatCatchController = TextEditingController();
  TextEditingController sampleSerialNumberController = TextEditingController();
  TextEditingController totalSampleWeightController = TextEditingController();
  TextEditingController speciesNameController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final fishingGroundList = [
    'Abelo, San Nicolas',
    'Ambulong, Tanauan City',
    'Bugaan East, Laurel',
    'Don Juan, Cuenca',
    'Kinalaglagan, Mataasnakahoy',
    'Nangkaan, Mataasnakahoy',
    'Napapanayan, Cuenca',
    'Poblacion, Laurel',
    'Saimsim, Santa Teresita',
    'Sampaloc, Talisay',
    'Subic Ibaba, Agoncillo',
    'Subic Ilaya, Agoncillo',
  ];

  String newText = '';
  String newTaskTitle = 'dfhkjas';
  DateTime dateTime = DateTime.now();

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text("Babalik ka ba?"),
          content: Text("Mawawala ang mga nasulat mo kung babalik ka ngayon"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Nagkamali ako ng pindot',
                  style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Oo, bumalik"),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.red,
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        print('Ikaw ay bumalik');

        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Container(
          //decoration: ,
          height: MediaQuery.of(context).size.height * 0.9,
          margin: EdgeInsets.all(20),
          child: Container(
              child: RawScrollbar(
                  thumbColor: Color.fromARGB(139, 76, 175, 79),
                  child: SingleChildScrollView(
                      reverse: false,
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        child: Text(
                                            "LANDED CATCH AND EFFORT MONITORING",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold))),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              DateFormat('MM/dd/yyyy h:ma')
                                                  .format(dateTime),
                                              style: TextStyle(fontSize: 18)),
                                          Text(
                                              "Tala ni: ${enumeratorController.text}",
                                              style: TextStyle(fontSize: 18))
                                        ]),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 30, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Detalye ng Lugar',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Icon(Icons.location_on)
                                          ],
                                        )),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Walang sagot; ilagay ang pangalan';
                                        }
                                        return null;
                                      },
                                      controller: enumeratorController,
                                      decoration: InputDecoration(
                                        labelText: 'Pangalan ng Enumerator',
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Walang sagot; pumili ng lugar';
                                        }
                                        return null;
                                      },
                                      controller: fishingGroundController,
                                      decoration: InputDecoration(
                                        labelText: 'Lugar ng Pinangisdaan',
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: DropdownSearch<String>(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Walang sagot; pumili ng lugar';
                                          }
                                          return null;
                                        },
                                        mode: Mode.DIALOG,
                                        items: [
                                          "Abelo, San Nicolas",
                                          "Ambulong, Tanauan City",
                                          "Bugaan East, Laurel",
                                          "Don Juan, Cuenca",
                                          "Kinalaglagan, Mataasnakahoy",
                                          "Nangkaan, Mataasnakahoy",
                                          "Napapanayan, Cuenca",
                                          "Poblacion, Laurel",
                                          "Saimsim, Santa Teresita",
                                          "Sampaloc, Talisay",
                                          "Subic Ibaba, Agoncillo",
                                          "Subic Ilaya, Agoncillo"
                                        ],
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelText: "Lugar ng Daungan",
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            landingCenterController.text =
                                                value!;
                                          });
                                        },
                                        showSearchBox: true,
                                        searchFieldProps: TextFieldProps(
                                          decoration: InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            prefixIcon: Icon(Icons.search),
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12, 12, 8, 0),
                                            labelText:
                                                "Hanapin ang Lugar ng Dinaungan",
                                          ),
                                        ),
                                        popupTitle: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 60, 136, 63),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Lugar ng Daungan',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        popupShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Walang sagot; ilagay ang dami ng dumaong';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: totalLandingsController,
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        labelText:
                                            "Bilang ng Lahat ng Dumaong Ngayong Araw",
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: 30, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Detalye ng Dumaong',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Icon(Icons.directions_boat)
                                          ],
                                        )),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Walang sagot; ilagay ang pangalan ng bangka';
                                        }
                                        return null;
                                      },
                                      controller: boatNameController,
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        labelText: "Pangalan ng Bangka",
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: DropdownSearch<String>(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Walang sagot; pumili ng gear';
                                          }
                                          return null;
                                        },
                                        mode: Mode.DIALOG,
                                        items: [
                                          "Gill Net (pante)",
                                          "Spear Gun (pana)",
                                          "Hook & Line (kawil)",
                                          "Fish Trap (bubo)",
                                          "Fish Corral (baklad)",
                                          "Lift Net (pantaas)",
                                          "Beach Seine (pukot)",
                                          "Scissors Net (salap)",
                                          "Crab Lift Net (bintol)",
                                          "Motorized Push Net (suro)",
                                          "Ring Net (basnig)",
                                          "Cover Pot (saklob)",
                                          "Fish Shelter (paksol)",
                                          "Drive-in Net (sakag/paksol)",
                                          "Bamboo Fish Trap (tukil)",
                                          "Scoop Net (sigpaw)",
                                          "Fish Spear (salapang)",
                                          "Rake (balukay)",
                                          "Cast Net (dala)",
                                          "Fish Pot (patanga)"
                                        ],
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          labelText: "Gear na Ginamit",
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            fishingGearController.text = value!;
                                          });
                                        },
                                        showSearchBox: true,
                                        searchFieldProps: TextFieldProps(
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.search),
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      12, 12, 8, 0),
                                              labelText:
                                                  "Hanapin ang Gear na Ginamit",
                                              labelStyle: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        popupTitle: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 60, 136, 63),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Fishing Gear',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        popupShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Walang sagot; ilagay ang tagal ng pangingisda';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: fishingEffortController,
                                      decoration: InputDecoration(
                                        labelText: "Tagal ng Pangingisda (hr)",
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      maxLength: 3,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Walang sagot; ilagay ang timbang ng hinuli';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: totalBoatCatchController,
                                      decoration: InputDecoration(
                                        labelText:
                                            "Pangkalahatang Timbang ng Nahuli (kg)",
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      maxLength: 5,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: 30, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Detalye ng Sample',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Icon(Icons.inbox)
                                          ],
                                        )),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Walang sagot; ilagay ang sample serial number';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: sampleSerialNumberController,
                                      decoration: InputDecoration(
                                        labelText: "Sample Serial Number",
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      maxLength: 4,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Walang sagot; ilagay ang timbang ng sample';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: totalSampleWeightController,
                                      decoration: InputDecoration(
                                        labelText: "Timbang ng Sample (kg)",
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      maxLength: 4,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5),
                                        child: TextButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // If the form is valid, display a snackbar. In the real world,
                                              // you'd often call a server or save the information in a database.
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            title: Text(
                                                                "Sigurado ka na ba sa mga nilagay mo?"),
                                                            content: Scrollbar(
                                                                child:
                                                                    SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Bago magpatuloy sa pagtala ng mga nahuling isda, siguraduhing tama ang mga detalye ukol sa pagtatalang ito"),
                                                                  Divider(
                                                                    thickness:
                                                                        3,
                                                                  ),
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              0,
                                                                          bottom:
                                                                              20),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text("Pangalan ng Enumerator:", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text(" ${enumeratorController.text}"),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text("\nLugar ng Pinangisdaan:", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text(" ${fishingGroundController.text}"),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text("\nLugar ng Daungan:", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text(" ${landingCenterController.text}"),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text("\nBilang ng Lahat ng Dumaong:", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text(" ${totalLandingsController.text} \n"),
                                                                            ],
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                3,
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text("\nPangalan ng Bangka: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text(" ${boatNameController.text}"),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text("\nGear na Ginamit: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text("${fishingGearController.text}"),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text("\nTagal ng Pangingisda: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text("${fishingEffortController.text} oras"),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text("\nTimbang ng Nahuli ng Bangka: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text("${totalBoatCatchController.text} kg \n"),
                                                                            ],
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                3,
                                                                          ),
                                                                          Column(
                                                                            // mainAxisAlignment:
                                                                            //     MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text("\nSample Serial Number: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text("${sampleSerialNumberController.text}"),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text("\nTimbang ng Sample: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text("${totalSampleWeightController.text}"),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ))
                                                                ],
                                                              ),
                                                            )),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Bumalik'),
                                                                child: Text(
                                                                    'Bumalik',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green)),
                                                              ),
                                                              TextButton(
                                                                onPressed:
                                                                    _showAddSpeciesModal,
                                                                child: Text(
                                                                    "Oo, sigurado na ako"),
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .white,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  //onSurface: Colors.grey,
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.8),
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: Offset(0,
                                                      4), // changes position of shadow
                                                ),
                                              ],
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "MAGPATULOY",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8),
                                                      child: FaIcon(
                                                          FontAwesomeIcons
                                                              .arrowRight,
                                                          color: Colors.white)),
                                                ]),
                                          ),
                                        ))
                                  ]))))))));
}
