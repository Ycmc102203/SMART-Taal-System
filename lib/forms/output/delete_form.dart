import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../backend/models/enumeratorRawData.dart';
import '../../backend/google_sheets_api.dart';
import '../../backend/sqlfite_local_offline_cache.dart';
import '../../backend/sqlfite_local_primary_db.dart';
import '../../widgets/loadingIndicator.dart';

showDeleteDialog(
    uuid,
    context,
    date,
    enumerator,
    landingCenter,
    fishingGround,
    totalLandings,
    boatName,
    fishingGear,
    fishingEffort,
    totalBoatCatch,
    sampleSerialNumber,
    sampleWeight,
    speciesName,
    length,
    weight) async {
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
            },
            child: Text('Nagkamali ako ng pindot',
                style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () async {
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
                    ['${uuid}']);
                await dbTwo.rawDelete(
                    'DELETE FROM enumeratorOfflineData WHERE uuid = ?',
                    ['${uuid}']);
                showTopSnackBar(
                    context,
                    CustomSnackBar.success(
                      message: 'Ayos! Na-delete na ang talang ito.',
                    ));
                Navigator.pushNamed(context, '/home');
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
                              ['${uuid}']);
                          await dbTwo.rawDelete(
                              'DELETE FROM enumeratorOfflineData WHERE uuid = ?',
                              ['${uuid}']);
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
                            EnumeratorRawDataColumn.uuid: uuid.trim(),
                            EnumeratorRawDataColumn.date: date.trim(),
                            EnumeratorRawDataColumn.enumerator:
                                enumerator.trim(),
                            EnumeratorRawDataColumn.landingCenter:
                                landingCenter.trim(),
                            EnumeratorRawDataColumn.fishingGround:
                                fishingGround.trim(),
                            EnumeratorRawDataColumn.totalLandings:
                                totalLandings.trim(),
                            EnumeratorRawDataColumn.boatName: boatName.trim(),
                            EnumeratorRawDataColumn.fishingGear:
                                fishingGear.trim(),
                            EnumeratorRawDataColumn.fishingEffort:
                                fishingEffort.trim(),
                            EnumeratorRawDataColumn.totalBoatCatch:
                                totalBoatCatch.trim(),
                            EnumeratorRawDataColumn.sampleSerialNumber:
                                sampleSerialNumber.trim(),
                            EnumeratorRawDataColumn.totalSampleWeight:
                                sampleWeight.trim(),
                            EnumeratorRawDataColumn.speciesName:
                                speciesName.trim(),
                            EnumeratorRawDataColumn.length: length.trim(),
                            EnumeratorRawDataColumn.weight: weight.trim(),
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

Future sleep() {
  return new Future.delayed(const Duration(milliseconds: 500), () => "1");
}
