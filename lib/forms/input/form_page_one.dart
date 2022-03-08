import 'package:flutter/material.dart';
import 'package:smart_taal_system/forms/fields/dropdown_field.dart';
import 'package:smart_taal_system/forms/input/form_page_two.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:smart_taal_system/forms/lists/fishing_gear_list.dart';
import 'package:smart_taal_system/forms/output/form_preview.dart';
import 'package:smart_taal_system/widgets/warnings/back_warning.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../widgets/buttons/add_button.dart';
import '../fields/text_input_field.dart';
import '../lists/landing_center_list.dart';
import 'arguments.dart';

class NewActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
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

  DateTime dateTime = DateTime.now();

  Future<bool?> showWarning(BuildContext context) async =>
      showDialog<bool>(context: context, builder: (context) => BackWarning());

  showPreview(BuildContext context) => showDialog<String>(
      context: context,
      builder: (BuildContext context) => FormPreview(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pangalan ng Enumerator:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(" ${enumeratorController.text}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\nLugar ng Pinangisdaan:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(" ${fishingGroundController.text}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\nLugar ng Daungan:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(" ${landingCenterController.text}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\nBilang ng Lahat ng Dumaong:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(" ${totalLandingsController.text} \n"),
                ],
              ),
              Divider(
                thickness: 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\nPangalan ng Bangka: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(" ${boatNameController.text}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\nGear na Ginamit: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("${fishingGearController.text}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\nTagal ng Pangingisda: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("${fishingEffortController.text} oras"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\nTimbang ng Nahuli ng Bangka: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("${totalBoatCatchController.text} kg \n"),
                ],
              ),
              Divider(
                thickness: 3,
              ),
              Column(
                // mainAxisAlignment:
                //     MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\nSample Serial Number: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("${sampleSerialNumberController.text}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\nTimbang ng Sample: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("${totalSampleWeightController.text}"),
                ],
              ),
            ],
            onPressed: () {
              Navigator.pushNamed(
                context,
                NewSpecies.routeName,
                arguments: Arguments(
                  dateTime,
                  enumeratorController.text,
                  fishingGroundController.text,
                  landingCenterController.text,
                  totalLandingsController.text,
                  boatNameController.text,
                  fishingGearController.text,
                  fishingEffortController.text,
                  totalBoatCatchController.text,
                  sampleSerialNumberController.text,
                  totalSampleWeightController.text,
                ),
              ).then((_) => setState(() {}));
            },
          ));

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        print('Ikaw ay bumalik');
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
          body: Container(
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
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, bottom: 10),
                                            child: Text(
                                                "LANDED CATCH AND EFFORT MONITORING",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  DateFormat('MM/dd/yyyy h:ma')
                                                      .format(dateTime),
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Text(
                                                  "Tala ni: ${enumeratorController.text}",
                                                  style:
                                                      TextStyle(fontSize: 18))
                                            ]),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 30, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Detalye ng Lugar',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Icon(Icons.location_on)
                                              ],
                                            )),
                                        TextInputField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Walang sagot; ilagay ang pangalan';
                                            }
                                            return null;
                                          },
                                          controller: enumeratorController,
                                          labelText: "Pangalan ng Enumerator",
                                          keyboardType: TextInputType.name,
                                        ),
                                        TextInputField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Walang sagot; pumili ng lugar';
                                            }
                                            return null;
                                          },
                                          controller: fishingGroundController,
                                          labelText: "Lugar ng Pinangisdaan",
                                          keyboardType: TextInputType.name,
                                        ),
                                        DropDownField(
                                          items: landingCentersList,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Walang sagot; pumili ng lugar';
                                            }
                                            return null;
                                          },
                                          labelTextOne: "Lugar ng Daungan",
                                          labelTextTwo:
                                              "Hanapin ang Lugar ng Dinaungan",
                                          labelTextThree: 'Lugar ng Daungan',
                                          onChanged: (String? value) {
                                            setState(() {
                                              landingCenterController.text =
                                                  value!;
                                            });
                                          },
                                        ),
                                        TextInputField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Walang sagot; ilagay ang dami ng dumaong';
                                            }
                                            return null;
                                          },
                                          controller: totalLandingsController,
                                          labelText:
                                              "Bilang ng Lahat ng Dumaong Ngayong Araw",
                                          keyboardType: TextInputType.number,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 30, bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Detalye ng Dumaong',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Icon(Icons.directions_boat)
                                              ],
                                            )),
                                        TextInputField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Walang sagot; ilagay ang pangalan ng bangka';
                                            }
                                            return null;
                                          },
                                          controller: boatNameController,
                                          labelText: "Pangalan ng Bangka",
                                          keyboardType: TextInputType.name,
                                        ),
                                        DropDownField(
                                            items: fishingGearList,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Walang sagot; pumili ng gear';
                                              }
                                              return null;
                                            },
                                            labelTextOne: "Gear na Ginamit",
                                            labelTextTwo:
                                                "Hanapin ang Gear na Ginamit",
                                            labelTextThree: 'Fishing Gear',
                                            onChanged: (String? value) {
                                              setState(() {
                                                fishingGearController.text =
                                                    value!;
                                              });
                                            }),
                                        TextInputField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Walang sagot; ilagay ang tagal ng pangingisda';
                                            }
                                            return null;
                                          },
                                          controller: fishingEffortController,
                                          labelText:
                                              "Tagal ng Pangingisda (oras)",
                                          keyboardType: TextInputType.number,
                                        ),
                                        TextInputField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Walang sagot; ilagay ang timbang ng hinuli';
                                            }
                                            return null;
                                          },
                                          controller: totalBoatCatchController,
                                          labelText:
                                              "Pangkalahatang Timbang ng Nahuli (kg)",
                                          keyboardType: TextInputType.number,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 30, bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Detalye ng Sample',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Icon(Icons.inbox)
                                              ],
                                            )),
                                        TextInputField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Walang sagot; ilagay ang sample serial number';
                                            }
                                            return null;
                                          },
                                          controller:
                                              sampleSerialNumberController,
                                          labelText: "Sample Serial Number",
                                          keyboardType: TextInputType.number,
                                        ),
                                        TextInputField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Walang sagot; ilagay ang timbang ng sample';
                                            }
                                            return null;
                                          },
                                          controller:
                                              totalSampleWeightController,
                                          labelText: "Timbang ng Sample (kg)",
                                          keyboardType: TextInputType.number,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5),
                                            child: AddButton(
                                                icon: FaIcon(
                                                    FontAwesomeIcons
                                                        .arrowCircleRight,
                                                    color: Colors.white),
                                                text: 'MAGPATULOY',
                                                function: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    showPreview(context);
                                                  } else {
                                                    showTopSnackBar(
                                                        context,
                                                        CustomSnackBar.error(
                                                          message:
                                                              "May kulang pa sa iyong tala. I-double check kung may laman na lahat.",
                                                        ));
                                                  }
                                                })),
                                      ])))))))));
}
