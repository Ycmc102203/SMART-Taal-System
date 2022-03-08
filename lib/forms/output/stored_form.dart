import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/backend/google_sheets_api.dart';
import 'package:smart_taal_system/backend/sqlfite_local_offline_cache.dart';
import 'package:smart_taal_system/backend/sqlfite_local_primary_db.dart';
import 'package:smart_taal_system/forms/fields/dropdown_field.dart';
import 'package:smart_taal_system/forms/fields/text_input_field.dart';
import 'package:smart_taal_system/forms/lists/fishing_gear_list.dart';
import 'package:smart_taal_system/forms/lists/landing_center_list.dart';
import 'package:smart_taal_system/forms/lists/species_list.dart';
import 'package:smart_taal_system/forms/output/edit_form.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../backend/enumeratorRawData.dart';
import '../../providers/refresh_provider.dart';
import '../../screens/dashboard_page.dart';
import '../../screens/home_page.dart';
import '../../widgets/loadingIndicator.dart';
import 'package:provider/provider.dart';

import 'delete_form.dart';

class storedForm extends StatefulWidget {
  final context;
  final uuid;
  final speciesName;
  final commonName;
  final speciesPic;
  final enumerator;
  final date;
  final fishingGround;
  final landingCenter;
  final totalLandings;
  final boatName;
  final fishingGear;
  final fishingEffort;
  final totalBoatCatch;
  final sampleSerialNumber;
  final sampleWeight;
  final weight;
  final length;

  storedForm({
    @required this.context,
    this.uuid,
    this.speciesName,
    this.commonName,
    this.speciesPic,
    this.enumerator,
    this.date,
    this.fishingGround,
    this.landingCenter,
    this.totalLandings,
    this.boatName,
    this.fishingGear,
    this.fishingEffort,
    this.totalBoatCatch,
    this.sampleSerialNumber,
    this.sampleWeight,
    this.weight,
    this.length,
  });

  @override
  _storedFormState createState() => _storedFormState();
}

class _storedFormState extends State<storedForm> {
  bool isEditing = true;

  TextEditingController speciesName = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController enumerator = TextEditingController();
  TextEditingController fishingGround = TextEditingController();
  TextEditingController landingCenter = TextEditingController();
  TextEditingController totalLandings = TextEditingController();
  TextEditingController boatName = TextEditingController();
  TextEditingController fishingGear = TextEditingController();
  TextEditingController fishingEffort = TextEditingController();
  TextEditingController totalBoatCatch = TextEditingController();
  TextEditingController sampleSerialNumber = TextEditingController();
  TextEditingController sampleWeight = TextEditingController();

  @override
  void initState() {
    setState(() {
      speciesName = TextEditingController(text: widget.speciesName);
      length = TextEditingController(text: widget.length);
      weight = TextEditingController(text: widget.weight);
      enumerator = TextEditingController(text: widget.enumerator);
      fishingGround = TextEditingController(text: widget.fishingGround);
      landingCenter = TextEditingController(text: widget.landingCenter);
      totalLandings = TextEditingController(text: widget.totalLandings);
      boatName = TextEditingController(text: widget.boatName);
      fishingGear = TextEditingController(text: widget.fishingGear);
      fishingEffort = TextEditingController(text: widget.fishingEffort);
      totalBoatCatch = TextEditingController(text: widget.totalBoatCatch);
      sampleSerialNumber =
          TextEditingController(text: widget.sampleSerialNumber);
      sampleWeight = TextEditingController(text: widget.sampleWeight);
    });
    super.initState();
  }

  void onEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  showEditDialog(uuid) {
    print(isEditing);
    return EditForm(
        context: widget.context,
        uuid: widget.uuid,
        speciesName: widget.speciesName,
        commonName: widget.commonName,
        speciesPic: widget.speciesPic,
        enumerator: widget.enumerator,
        date: widget.date,
        fishingGround: widget.fishingGround,
        landingCenter: widget.landingCenter,
        totalLandings: widget.totalLandings,
        boatName: widget.boatName,
        fishingGear: widget.fishingGear,
        fishingEffort: widget.fishingEffort,
        totalBoatCatch: widget.totalBoatCatch,
        sampleSerialNumber: widget.sampleSerialNumber,
        sampleWeight: widget.sampleWeight,
        weight: widget.weight,
        length: widget.length);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                            Text("${widget.date}"),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('I-edit',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                      onPressed: () {
                                        onEdit();
                                      },
                                      icon: Icon(Icons.edit,
                                          color: Colors.green)),
                                  Text('I-delete',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                      onPressed: () {
                                        showDeleteDialog(
                                            widget.uuid,
                                            context,
                                            widget.date,
                                            widget.enumerator,
                                            widget.landingCenter,
                                            widget.fishingGround,
                                            widget.totalLandings,
                                            widget.boatName,
                                            widget.fishingGear,
                                            widget.fishingEffort,
                                            widget.totalBoatCatch,
                                            widget.sampleSerialNumber,
                                            widget.sampleWeight,
                                            widget.speciesName,
                                            widget.length,
                                            widget.weight);
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.red)),
                                ]),
                          ]),
                      isEditing
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Image.asset(widget.speciesPic),
                                  Text("\nDetalye ng Isda",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text("\n${widget.commonName}"),
                                  Text("${widget.speciesName}",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic)),
                                  Text(
                                      "Haba: ${widget.length} cm     Bigat: ${widget.weight} g"),
                                  Text("\nDetalye ng Lugar",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text("\nTinala ni: ${widget.enumerator}"),
                                  Text("Nahuli sa: ${widget.fishingGround}"),
                                  Text("Dinaong sa: ${widget.landingCenter}"),
                                  Text(
                                      "Bilang ng mga dumaong: ${widget.totalLandings}"),
                                  Text("\nDetalye ng Dumaong",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "Pangalan ng Bangka: ${widget.boatName}"),
                                  Text(
                                      "Pangalan ng Gear na Ginamit: ${widget.fishingGear}"),
                                  Text(
                                      "Tagal ng Pangingisda: ${widget.fishingEffort} oras"),
                                  Text(
                                      "Timbang ng Nahuli: ${widget.totalBoatCatch} kg"),
                                  Text("\nDetalye ng Sample",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "Sample Serial Number: ${widget.sampleSerialNumber}"),
                                  Text(
                                      "Timbang ng Nahuli: ${widget.sampleWeight} kg"),
                                ])
                          : showEditDialog(widget.uuid)
                    ])))));
  }
}

bool isLoading = false;

Future sleep() {
  return new Future.delayed(const Duration(milliseconds: 500), () => "1");
}
