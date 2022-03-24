import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/forms/fields/dropdown_field.dart';
import 'package:smart_taal_system/widgets/buttons/submit_button.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../backend/models/enumeratorRawData.dart';
import '../../backend/google_sheets_api.dart';
import '../../backend/sqlfite_local_primary_db.dart';
import '../../widgets/loadingIndicator.dart';
import '../fields/text_input_field.dart';
import '../lists/fishing_gear_list.dart';
import '../lists/landing_center_list.dart';
import '../lists/species_list.dart';
import 'delete_form.dart';

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
  TextEditingController commonName = TextEditingController();
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
  TextEditingController speciesPic = TextEditingController();
  final _formEditKey = GlobalKey<FormState>();
  @override
  void initState() {
    setState(() {
      speciesName = TextEditingController(text: widget.speciesName);
      commonName = TextEditingController(text: widget.commonName);
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
      speciesPic = TextEditingController(text: widget.speciesPic);
    });
    super.initState();
  }

  void _changeCommonToSciName() {
    if (commonName.text == "Flag-tailed glass perchlet (ning-ning)") {
      setState(() {
        speciesName.text = "Ambassis miops";
        speciesPic.text = 'assets/Ambassis miops.PNG';
      });
    } else if (commonName.text == "Midas cichlid (red tilapia)") {
      setState(() {
        speciesName.text = "Amphilophus citrinellus";
        speciesPic.text = 'assets/Amphilophus citrinellus.PNG';
      });
    } else if (commonName.text == "Climbing perch (martiniko)") {
      setState(() {
        speciesName.text = "Anabas testudineus";
        speciesPic.text = 'assets/Anabas testudineus.PNG';
      });
    } else if (commonName.text == "Giant mottled eel (igat)") {
      setState(() {
        speciesName.text = "Anguilla marmorata";
        speciesPic.text = 'assets/Anguilla marmorata.PNG';
      });
    } else if (commonName.text == "Manila sea catfish (kanduli)") {
      setState(() {
        speciesName.text = "Arius manillensis";
        speciesPic.text = 'assets/Arius manillensis.PNG';
      });
    } else if (commonName.text == "Eendracht Land silverside (guno)") {
      setState(() {
        speciesName.text = "Atherinomorus endrachtensis";
        speciesPic.text = 'assets/Atherinomorus endrachtensis.PNG';
      });
    } else if (commonName.text == "Giant trevally (maliputo)") {
      setState(() {
        speciesName.text = "Caranx ignobilis";
        speciesPic.text = 'assets/Caranx ignobilis.PNG';
      });
    } else if (commonName.text == "Big-eye trevally (muslo)") {
      setState(() {
        speciesName.text = "Caranx sexfasciatus";
        speciesPic.text = 'assets/Caranx sexfasciatus.PNG';
      });
    } else if (commonName.text == "Crucian carp (karpita)") {
      setState(() {
        speciesName.text = "Carassius carassius";
        speciesPic.text = 'assets/Carassius carassius.PNG';
      });
    } else if (commonName.text == "Striped snakehead (dalag)") {
      setState(() {
        speciesName.text = "Channa striata";
        speciesPic.text = 'assets/Channa striata.PNG';
      });
    } else if (commonName.text == "Milkfish (bangus)") {
      setState(() {
        speciesName.text = "Chanos chanos";
        speciesPic.text = 'assets/Chanos chanos.PNG';
      });
    } else if (commonName.text == "Philippine catfish (hito)") {
      setState(() {
        speciesName.text = "Clarias batrachus";
        speciesPic.text = 'assets/Clarias batrachus.PNG';
      });
    } else if (commonName.text == "Bighead catfish (hito)") {
      setState(() {
        speciesName.text = "Clarias macrocephalus";
        speciesPic.text = 'assets/Clarias macrocephalus.PNG';
      });
    } else if (commonName.text == "Common carp (karpa)") {
      setState(() {
        speciesName.text = "Cyprinus carpio";
        speciesPic.text = 'assets/Cyprinus carpio.PNG';
      });
    } else if (commonName.text == "Pipefish (kambabalo)") {
      setState(() {
        speciesName.text = "Doryichthys martensii";
        speciesPic.text = 'assets/Doryichthys martensii.PNG';
      });
    } else if (commonName.text == "Tenpounder (Kanoping)") {
      setState(() {
        speciesName.text = "Elops machnata";
        speciesPic.text = 'assets/Elops machnata.PNG';
      });
    } else if (commonName.text == "Half-barred cardinal (dangat)") {
      setState(() {
        speciesName.text = "Fibramia thermalis";
        speciesPic.text = 'assets/Fibramia thermalis.PNG';
      });
    } else if (commonName.text == "Whipfin silver-biddy (balabatuhan)") {
      setState(() {
        speciesName.text = "Gerres filamentosus";
        speciesPic.text = 'assets/Gerres filamentosus.PNG';
      });
    } else if (commonName.text == "Snakehead gudgeon (baculi)") {
      setState(() {
        speciesName.text = "Giuris margaritacea";
        speciesPic.text = 'assets/Giuris margaritacea.PNG';
      });
    } else if (commonName.text == "Celebes goby (biyang bato)") {
      setState(() {
        speciesName.text = "Glossogobius celebius";
        speciesPic.text = 'assets/Glossogobius celebius.PNG';
      });
    } else if (commonName.text == "Tank goby (biyang puti)") {
      setState(() {
        speciesName.text = "Glossogobius giuris";
        speciesPic.text = 'assets/Glossogobius giuris.PNG';
      });
    } else if (commonName.text == "Bighead carp (bighead)") {
      setState(() {
        speciesName.text = "Hypophthalmichthys nobilis";
        speciesPic.text = 'assets/Hypophthalmichthys nobilis.PNG';
      });
    } else if (commonName.text == "Quoy's garfish (siliw)") {
      setState(() {
        speciesName.text = "Hyporhamphus quoyi";
        speciesPic.text = 'assets/Hyporhamphus quoyi.PNG';
      });
    } else if (commonName.text == "Barramundi (apahap)") {
      setState(() {
        speciesName.text = "Lates calcarifer";
        speciesPic.text = 'assets/Lates calcarifer.PNG';
      });
    } else if (commonName.text == "Silver perch (ayungin)") {
      setState(() {
        speciesName.text = "Leiopotherapon plumbeus";
        speciesPic.text = 'assets/Leiopotherapon plumbeus.PNG';
      });
    } else if (commonName.text == "Mangrove red snapper (also)") {
      setState(() {
        speciesName.text = "Lutjanus argentimaculatus";
        speciesPic.text = 'assets/Lutjanus argentimaculatus.PNG';
      });
    } else if (commonName.text == "Malabar blood snapper (maya-maya)") {
      setState(() {
        speciesName.text = "Lutjanus malabaricus";
        speciesPic.text = 'assets/Lutjanus malabaricus.PNG';
      });
    } else if (commonName.text == "Indo-Pacific tarpon (buan-buan)") {
      setState(() {
        speciesName.text = "Megalops cyprinoides";
        speciesPic.text = 'assets/Megalops cyprinoides.PNG';
      });
    } else if (commonName.text == "Sharptail goby (biya)") {
      setState(() {
        speciesName.text = "Oligolepis acutipennis";
        speciesPic.text = 'assets/Oligolepis acutipennis.PNG';
      });
    } else if (commonName.text == "Gossamer blenny (isdang mamay)") {
      setState(() {
        speciesName.text = "Omobranchus ferox";
        speciesPic.text = 'assets/Omobranchus ferox.PNG';
      });
    } else if (commonName.text == "Nile tilapia (tilapia)") {
      setState(() {
        speciesName.text = "Oreochromis niloticus";
        speciesPic.text = 'assets/Oreochromis niloticus.PNG';
      });
    } else if (commonName.text == "Striped catfish (pangasius)") {
      setState(() {
        speciesName.text = "Pangasianodon hypophthalmus";
        speciesPic.text = 'assets/Pangasianodon hypophthalmus.PNG';
      });
    } else if (commonName.text == "Jaguar guapote (dugong)") {
      setState(() {
        speciesName.text = "Parachromis managuensis";
        speciesPic.text = 'assets/Parachromis managuensis.PNG';
      });
    } else if (commonName.text == "Greenback mullet (Banak)") {
      setState(() {
        speciesName.text = "Planiliza subviridis";
        speciesPic.text = 'assets/Planiliza subviridis.PNG';
      });
    } else if (commonName.text == "Sleepy goby (biya)") {
      setState(() {
        speciesName.text = "Psammogobius biocellatus";
        speciesPic.text = 'assets/Psammogobius biocellatus.PNG';
      });
    } else if (commonName.text ==
        "Vermiculated sailfin catfish (janitor fish)") {
      setState(() {
        speciesName.text = "Pterygoplichthys disjunctivus";
        speciesPic.text = 'assets/Pterygoplichthys disjunctivus.PNG';
      });
    } else if (commonName.text == "Freshwater sardine (tawilis)") {
      setState(() {
        speciesName.text = "Sardinella tawilis";
        speciesPic.text = 'assets/Sardinella tawilis.PNG';
      });
    } else if (commonName.text == "Blackchin tilapia (tilapiang arroyo)") {
      setState(() {
        speciesName.text = "Sarotherodon melanotheron";
        speciesPic.text = 'assets/Sarotherodon melanotheron.PNG';
      });
    } else if (commonName.text == "Spotted scat (kitang)") {
      setState(() {
        speciesName.text = "Scatophagus argus";
        speciesPic.text = 'assets/Scatophagus argus.PNG';
      });
    } else if (commonName.text == "Jarbua terapon (bagaong)") {
      setState(() {
        speciesName.text = "Terapon jarbua";
        speciesPic.text = 'assets/Terapon jarbua.PNG';
      });
    } else if (commonName.text == "Banded archerfish (kataba)") {
      setState(() {
        speciesName.text = "Toxotes jaculatrix";
        speciesPic.text = 'assets/Toxotes jaculatrix.PNG';
      });
    } else if (commonName.text == "Three spot gourami (gurami)") {
      setState(() {
        speciesName.text = "Trichopodus trichopterus";
        speciesPic.text = 'assets/Trichopodus trichopterus.PNG';
      });
    } else if (commonName.text == "Humpbacked cardinalfish (muang)") {
      setState(() {
        speciesName.text = "Yarica hyalosoma";
        speciesPic.text = 'assets/Yarica hyalosoma.PNG';
      });
    } else if (commonName.text == "Feathered river-garfish (siliw)") {
      setState(() {
        speciesName.text = "Zenarchopterus dispar";
        speciesPic.text = 'assets/Zenarchopterus dispar.PNG';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Image.asset(speciesPic.text),
        Text("\n---PAG-EEDIT NG TALA---",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.green)),
        Form(
          key: _formEditKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\nDetalye ng Isda",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
              DropDownField(
                items: speciesList,
                selectedItem: widget.commonName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Walang sagot; siguraduhing may laman ang tala';
                  }
                  return null;
                },
                labelTextOne: "Pangalan ng Isda",
                labelTextTwo: "Hanapin ang Isdang Sinukat",
                icon: FaIcon(FontAwesomeIcons.fish),
                onChanged: (String? value) {
                  setState(() {
                    commonName.text = value!;
                    print(commonName.text);
                  });
                  _changeCommonToSciName();
                },
              ),
              TextInputField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Walang sagot; siguraduhing may laman ang tala';
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
                  labelText: "Bigat ng Isda (g)",
                  keyboardType: TextInputType.number),
              Text("\nDetalye ng Lugar",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
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
              // TextInputField(
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Walang sagot; ilagay ang timbang';
              //       }
              //       return null;
              //     },
              //     controller: fishingGround,
              //     labelText: "Lugar na Pinangisdaan",
              //     keyboardType: TextInputType.name),
              DropDownField(
                items: ['Commercial', 'Municipal'],
                selectedItem: widget.fishingGround,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Walang sagot; siguraduhing may laman ang tala';
                  }
                  return null;
                },
                labelTextOne: "Lugar na Pinangisdaan",
                labelTextTwo: "Hanapin ang Lugar na Pinangisdaan",
                icon: Icon(Icons.location_on),
                onChanged: (String? value) {
                  setState(() {
                    fishingGround.text = value!;
                  });
                },
              ),
              DropDownField(
                items: landingCentersList,
                selectedItem: widget.landingCenter,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Walang sagot; siguraduhing may laman ang tala';
                  }
                  return null;
                },
                labelTextOne: "Lugar Daungan",
                labelTextTwo: "Hanapin ang Lugar na Dinaungan",
                icon: Icon(Icons.location_on),
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
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
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
                    return 'Walang sagot; siguraduhing may laman ang tala';
                  }
                  return null;
                },
                labelTextOne: "Gear na Ginamit",
                labelTextTwo: "Hanapin ang Gear na Ginamit",
                icon: Icon(Icons.directions_boat),
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
              Text("\nDetalye ng Sample",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
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
              SubmitButton(
                  text: 'I-UPDATE',
                  function: () async {
                    bool isConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (isConnected == true) {
                      if (_formEditKey.currentState!.validate()) {
                        showDialog(
                            context: context,
                            builder: (context) => LoadingDialog(
                                color: Colors.green, text: "Inu-update"));
                        try {
                          final feedback = {
                            EnumeratorRawDataColumn.enumerator:
                                enumerator.text.trim(),
                            EnumeratorRawDataColumn.landingCenter:
                                landingCenter.text.trim(),
                            EnumeratorRawDataColumn.fishingGround:
                                fishingGround.text.trim(),
                            EnumeratorRawDataColumn.totalLandings:
                                totalLandings.text.trim(),
                            EnumeratorRawDataColumn.boatName:
                                boatName.text.trim(),
                            EnumeratorRawDataColumn.fishingGear:
                                fishingGear.text.trim(),
                            EnumeratorRawDataColumn.fishingEffort:
                                fishingEffort.text.trim(),
                            EnumeratorRawDataColumn.totalBoatCatch:
                                totalBoatCatch.text.trim(),
                            EnumeratorRawDataColumn.sampleSerialNumber:
                                sampleSerialNumber.text.trim(),
                            EnumeratorRawDataColumn.totalSampleWeight:
                                sampleWeight.text.trim(),
                            EnumeratorRawDataColumn.speciesName:
                                speciesName.text.trim(),
                            EnumeratorRawDataColumn.length: length.text.trim(),
                            EnumeratorRawDataColumn.weight: weight.text.trim(),
                          };
                          await GoogleSheetsApi.update(
                              uuid: widget.uuid, row: feedback);
                          Database dbOne =
                              await DatabaseHelperOne.instance.database;
                          await dbOne.rawUpdate(
                              '''UPDATE enumeratorLocalData SET enumerator = ?, landingCenter = ?, fishingGround = ?, totalLandings = ?, boatName = ?, fishingGear = ?, fishingEffort = ?, totalBoatCatch = ?, sampleSerialNumber = ?, totalSampleWeight = ?, speciesName = ?, commonName = ?, length = ?, weight = ?, image = ? WHERE uuid = ?''',
                              [
                                enumerator.text,
                                landingCenter.text,
                                fishingGround.text,
                                totalLandings.text,
                                boatName.text,
                                fishingGear.text,
                                fishingEffort.text,
                                totalBoatCatch.text,
                                sampleSerialNumber.text,
                                sampleWeight.text,
                                speciesName.text,
                                commonName.text,
                                length.text,
                                weight.text,
                                speciesPic.text,
                                widget.uuid
                              ]);
                          showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                message: 'Ayos! Na-update na ang talang ito.',
                              ));
                          setState(() {});
                          Navigator.pushNamed(context, '/home');
                        } catch (e) {
                          showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                message:
                                    'ERROR: Hindi mahanap ang tala sa Database',
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
                                  "Hindi pala ito natala sa GoogleSheets Database. Gusto mo bang i-upload doon?"),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await sleep();
                                    showDialog(
                                        context: context,
                                        builder: (context) => LoadingDialog(
                                            color: Colors.green,
                                            text: "Inu-upload"));
                                    await sleep();
                                    final feedbackUpload = {
                                      EnumeratorRawDataColumn.uuid:
                                          widget.uuid.trim(),
                                      EnumeratorRawDataColumn.date:
                                          widget.date.trim(),
                                      EnumeratorRawDataColumn.enumerator:
                                          enumerator.text.trim(),
                                      EnumeratorRawDataColumn.landingCenter:
                                          landingCenter.text.trim(),
                                      EnumeratorRawDataColumn.fishingGround:
                                          fishingGround.text.trim(),
                                      EnumeratorRawDataColumn.totalLandings:
                                          totalLandings.text.trim(),
                                      EnumeratorRawDataColumn.boatName:
                                          boatName.text.trim(),
                                      EnumeratorRawDataColumn.fishingGear:
                                          fishingGear.text.trim(),
                                      EnumeratorRawDataColumn.fishingEffort:
                                          fishingEffort.text.trim(),
                                      EnumeratorRawDataColumn.totalBoatCatch:
                                          totalBoatCatch.text.trim(),
                                      EnumeratorRawDataColumn
                                              .sampleSerialNumber:
                                          sampleSerialNumber.text.trim(),
                                      EnumeratorRawDataColumn.totalSampleWeight:
                                          sampleWeight.text.trim(),
                                      EnumeratorRawDataColumn.speciesName:
                                          speciesName.text.trim(),
                                      EnumeratorRawDataColumn.length:
                                          length.text.trim(),
                                      EnumeratorRawDataColumn.weight:
                                          weight.text.trim(),
                                    };
                                    await GoogleSheetsApi.insert(
                                        [feedbackUpload]);
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
                      } else {
                        showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message:
                                  "May mga blangko sa iyong i-nedit na tala. I-double check kung may laman na lahat.",
                            ));
                      }
                    } else {
                      showTopSnackBar(
                          context,
                          CustomSnackBar.error(
                            message:
                                "Kailangan mo munang magkaron ng koneksyon upang mag-edit.",
                          ));
                    }
                  },
                  icon: Icon(Icons.cloud_upload, size: 25, color: Colors.white))
            ],
          ),
        ),
      ],
    ));
  }
}
