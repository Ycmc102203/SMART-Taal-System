import 'package:flutter/material.dart';

showStoredForm(
    BuildContext context,
    String speciesName,
    String commonName,
    String speciesPic,
    String enumerator,
    String date,
    String fishingGround,
    String landingCenter,
    String totalLandings,
    String boatName,
    String fishingGear,
    String fishingEffort,
    String totalBoatCatch,
    String sampleSerialNumber,
    String sampleWeight,
    String weight,
    String length) {
  ;
  var alert = AlertDialog(
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
                      Image.asset(speciesPic),
                      Text("\n${speciesName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      Text("${commonName}"),
                      Text("Haba: ${length} cm     Bigat: ${weight} g"),
                      Text("\n${date}"),
                      Text("\nDetalye ng Lugar",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Tinala ni: ${enumerator}"),
                      Text("Nahuli sa: ${fishingGround}"),
                      Text("Dinaong sa: ${landingCenter}"),
                      Text("Bilang ng mga dumaong: ${totalLandings}"),
                      Text("\nDetalye ng Dumaong",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Pangalan ng Bangka: ${boatName}"),
                      Text("Pangalan ng Gear na Ginamit: ${fishingGear}"),
                      Text("Tagal ng Pangingisda: ${fishingEffort} hr/s"),
                      Text("Timbang ng Nahuli: ${totalBoatCatch} kg"),
                      Text("\nDetalye ng Sample",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Sample Serial Number: ${sampleSerialNumber}"),
                      Text("Timbang ng Nahuli: ${sampleWeight} kg"),
                    ]),
              ))));
  showDialog(context: context, builder: (BuildContext context) => alert);
}
