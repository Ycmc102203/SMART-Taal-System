import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/backend/google_sheets_api.dart';
import 'package:smart_taal_system/backend/sqlfite_local_offline_cache.dart';
import 'package:smart_taal_system/backend/sqlfite_local_primary_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../backend/enumeratorRawData.dart';
import '../../providers/refresh_provider.dart';
import '../../screens/dashboard_page.dart';
import '../../screens/home_page.dart';
import '../../widgets/loadingIndicator.dart';
import 'package:provider/provider.dart';

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
  showDeleteDialog(uuid, context) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    print(isConnected);
    if (isConnected == true) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text("Delete"),
          content: Text("Sigurado ka ba na i-dedelete mo ang talang ito?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              child: Text('Nagkamali ako ng pindot',
                  style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                setState(() {});
                showDialog(
                    context: context,
                    builder: (context) =>
                        LoadingDialog(color: Colors.red, text: "Dinedelete"));
                try {
                  await GoogleSheetsApi.deleteByUuid(uuid: uuid);
                  Database dbOne = await DatabaseHelperOne.instance.database;
                  Database dbTwo = await DatabaseHelperTwo.instance.database;
                  await dbOne.rawDelete(
                      'DELETE FROM enumeratorLocalData WHERE uuid = ?',
                      ['${widget.uuid}']);
                  await dbTwo.rawDelete(
                      'DELETE FROM enumeratorOfflineData WHERE uuid = ?',
                      ['${widget.uuid}']);
                  showTopSnackBar(
                      context,
                      CustomSnackBar.success(
                        message: 'Ayos! Na-delete na ang talang ito.',
                      ));
                  Navigator.pushNamed(context, '/');
                } catch (e) {
                  showTopSnackBar(
                      context,
                      CustomSnackBar.error(
                        message: 'ERROR: Hindi mahanap ang tala sa Database',
                      ));
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text("ERROR"),
                      content: Text(
                          "Hindi pala ito natala sa GoogleSheets Database. Gusto mo bang i-delete pa ito o i-upload doon?"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            setState(() {});
                            showDialog(
                                context: context,
                                builder: (context) => LoadingDialog(
                                    color: Colors.red, text: "Dinedelete"));
                            Database dbOne =
                                await DatabaseHelperOne.instance.database;
                            Database dbTwo =
                                await DatabaseHelperTwo.instance.database;
                            await dbOne.rawDelete(
                                'DELETE FROM enumeratorLocalData WHERE uuid = ?',
                                ['${widget.uuid}']);
                            await dbTwo.rawDelete(
                                'DELETE FROM enumeratorOfflineData WHERE uuid = ?',
                                ['${widget.uuid}']);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('I-delete',
                              style: TextStyle(color: Colors.red)),
                        ),
                        TextButton(
                          onPressed: () async {
                            await sleep();
                            showDialog(
                                context: context,
                                builder: (context) => LoadingDialog(
                                    color: Colors.green, text: "Inu-upload"));
                            await sleep();
                            final feedback = {
                              EnumeratorRawDataColumn.uuid: widget.uuid.trim(),
                              EnumeratorRawDataColumn.date: widget.date.trim(),
                              EnumeratorRawDataColumn.enumerator:
                                  widget.enumerator.trim(),
                              EnumeratorRawDataColumn.landingCenter:
                                  widget.landingCenter.trim(),
                              EnumeratorRawDataColumn.fishingGround:
                                  widget.fishingGround.trim(),
                              EnumeratorRawDataColumn.totalLandings:
                                  widget.totalLandings.trim(),
                              EnumeratorRawDataColumn.boatName:
                                  widget.boatName.trim(),
                              EnumeratorRawDataColumn.fishingGear:
                                  widget.fishingGear.trim(),
                              EnumeratorRawDataColumn.fishingEffort:
                                  widget.fishingEffort.trim(),
                              EnumeratorRawDataColumn.totalBoatCatch:
                                  widget.totalBoatCatch.trim(),
                              EnumeratorRawDataColumn.sampleSerialNumber:
                                  widget.sampleSerialNumber.trim(),
                              EnumeratorRawDataColumn.totalSampleWeight:
                                  widget.sampleWeight.trim(),
                              EnumeratorRawDataColumn.speciesName:
                                  widget.speciesName.trim(),
                              EnumeratorRawDataColumn.length:
                                  widget.length.trim(),
                              EnumeratorRawDataColumn.weight:
                                  widget.weight.trim(),
                            };
                            await GoogleSheetsApi.insert([feedback]);
                            showTopSnackBar(
                                context,
                                CustomSnackBar.success(
                                  message:
                                      'Ayos! Nai-upload na ang talang ito sa database',
                                ));
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text("Oo, i-upload"),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.red,
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
              child: Text("Oo, i-delete na"),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.red,
              ),
            )
          ],
        ),
      );
    } else {
      showTopSnackBar(
          context,
          CustomSnackBar.error(
            message:
                "Paalala! Kumonekta muna sa internet para makapag-delete ng tala",
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32))),
        content: RawScrollbar(
            thumbColor: Colors.green,
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                                          showEditDialog(widget.uuid);
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
                                              widget.uuid, context);
                                        },
                                        icon: Icon(Icons.delete,
                                            color: Colors.red)),
                                  ]),
                            ]),
                        Image.asset(widget.speciesPic),
                        Text("\n${widget.commonName}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text("${widget.speciesName}"),
                        Text(
                            "Haba: ${widget.length} cm     Bigat: ${widget.weight} g"),
                        Text("\nDetalye ng Lugar",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Tinala ni: ${widget.enumerator}"),
                        Text("Nahuli sa: ${widget.fishingGround}"),
                        Text("Dinaong sa: ${widget.landingCenter}"),
                        Text("Bilang ng mga dumaong: ${widget.totalLandings}"),
                        Text("\nDetalye ng Dumaong",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Pangalan ng Bangka: ${widget.boatName}"),
                        Text(
                            "Pangalan ng Gear na Ginamit: ${widget.fishingGear}"),
                        Text(
                            "Tagal ng Pangingisda: ${widget.fishingEffort} oras"),
                        Text("Timbang ng Nahuli: ${widget.totalBoatCatch} kg"),
                        Text("\nDetalye ng Sample",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            "Sample Serial Number: ${widget.sampleSerialNumber}"),
                        Text("Timbang ng Nahuli: ${widget.sampleWeight} kg"),
                      ]),
                ))));
  }
}

bool isLoading = false;
showEditDialog(uuid) {
  print('editssss ' + uuid);
}

Future sleep() {
  return new Future.delayed(const Duration(milliseconds: 500), () => "1");
}
