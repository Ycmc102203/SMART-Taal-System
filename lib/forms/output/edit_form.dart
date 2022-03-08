import 'package:flutter/material.dart';
import 'package:smart_taal_system/forms/fields/dropdown_field.dart';

import '../fields/text_input_field.dart';
import '../lists/fishing_gear_list.dart';
import '../lists/landing_center_list.dart';
import '../lists/species_list.dart';

class EditForm extends StatefulWidget {
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
  const EditForm(
      {Key? key,
      required this.context,
      required this.uuid,
      required this.speciesName,
      required this.commonName,
      required this.speciesPic,
      required this.enumerator,
      required this.date,
      required this.fishingGround,
      required this.landingCenter,
      required this.totalLandings,
      required this.boatName,
      required this.fishingGear,
      required this.fishingEffort,
      required this.totalBoatCatch,
      required this.sampleSerialNumber,
      required this.sampleWeight,
      required this.weight,
      required this.length})
      : super(key: key);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(widget.speciesPic),
        Text("\nDetalye ng Isda",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        DropDownField(
          items: speciesList,
          selectedItem: widget.commonName,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Walang sagot; pumili ng isda';
            }
            return null;
          },
          labelTextOne: "Pangalan ng Isda",
          labelTextTwo: "Hanapin ang Isdang Sinukat",
          labelTextThree: 'Pangalan ng Isda',
          onChanged: (String? value) {
            setState(() {
              speciesName.text = value!;
            });
          },
        ),
        TextInputField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Walang sagot; pumili ng isda';
            }
            return null;
          },
          controller: length,
          labelText: "Haba ng Isda (cm)",
          keyboardType: TextInputType.number,
        ),
        TextInputField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Walang sagot; ilagay ang timbang';
              }
              return null;
            },
            controller: weight,
            labelText: "Pangalan ng Isda",
            keyboardType: TextInputType.name),
        Text("\nDetalye ng Lugar",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        TextInputField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Walang sagot; ilagay ang timbang';
              }
              return null;
            },
            controller: enumerator,
            labelText: "Pangalan ng Enumerator",
            keyboardType: TextInputType.name),
        TextInputField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Walang sagot; ilagay ang timbang';
              }
              return null;
            },
            controller: fishingGround,
            labelText: "Lugar na Pinangisdaan",
            keyboardType: TextInputType.name),
        DropDownField(
          items: landingCentersList,
          selectedItem: widget.landingCenter,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Walang sagot; pumili ng isda';
            }
            return null;
          },
          labelTextOne: "Lugar Daungan",
          labelTextTwo: "Hanapin ang Lugar na Dinaungan",
          labelTextThree: 'Lugar Daungan',
          onChanged: (String? value) {
            setState(() {
              landingCenter.text = value!;
            });
          },
        ),
        TextInputField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Walang sagot; ilagay ang timbang';
              }
              return null;
            },
            controller: weight,
            labelText: "Bilang ng mga Dumaong",
            keyboardType: TextInputType.number),
        Text("\nDetalye ng Dumaong",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        TextInputField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Walang sagot; ilagay ang timbang';
              }
              return null;
            },
            controller: boatName,
            labelText: "Pangalan ng Bangka",
            keyboardType: TextInputType.name),
        DropDownField(
          items: fishingGearList,
          selectedItem: widget.fishingGear,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Walang sagot; pumili ng isda';
            }
            return null;
          },
          labelTextOne: "Gear na Ginamit",
          labelTextTwo: "Hanapin ang Gear na Ginamit",
          labelTextThree: 'Gear na Ginamit',
          onChanged: (String? value) {
            setState(() {
              landingCenter.text = value!;
            });
          },
        ),
        TextInputField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Walang sagot; ilagay ang timbang';
              }
              return null;
            },
            controller: fishingEffort,
            labelText: "Tagal ng Pangingisda (hr)",
            keyboardType: TextInputType.number),
        TextInputField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Walang sagot; ilagay ang timbang';
              }
              return null;
            },
            controller: totalBoatCatch,
            labelText: "Timbang ng Nahuli",
            keyboardType: TextInputType.number),
        Text("\nDetalye ng Dumaong",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        TextInputField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Walang sagot; ilagay ang timbang';
              }
              return null;
            },
            controller: sampleSerialNumber,
            labelText: "Sample Serial Number",
            keyboardType: TextInputType.number),
        TextInputField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Walang sagot; ilagay ang timbang';
              }
              return null;
            },
            controller: sampleWeight,
            labelText: "Timbang ng Sample",
            keyboardType: TextInputType.number),
      ],
    ));
  }
}
