import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/backend/enumeratorRawData.dart';
import 'package:smart_taal_system/backend/google_sheets_api.dart';
import 'package:smart_taal_system/backend/sqlfite_local_offline_cache.dart';
import 'package:smart_taal_system/forms/fields/text_input_field.dart';
import 'package:smart_taal_system/forms/output/form_preview.dart';
import 'package:smart_taal_system/screens/home_page.dart';
import 'package:smart_taal_system/widgets/buttons/submit_button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';
import '../../backend/sqlfite_local_primary_db.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import '../../widgets/buttons/add_button.dart';
import '../../widgets/loadingIndicator.dart';
import '../fields/dropdown_field.dart';
import 'arguments.dart';

class NewSpecies extends StatefulWidget {
  static const routeName = '/form_two';

  @override
  State<StatefulWidget> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewSpecies> {
  final _formKeyTwo = GlobalKey<FormState>();
  final List<String> species = <String>[];
  final List<String> pic = <String>[];
  final List<String> length = <String>[];
  final List<String> weight = <String>[];
  final List<String> commonName = <String>[];
  String speciesPic = '';

  var uuid = Uuid();

  Future<bool?> showAddQuestion(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text("Magtatala ka ba ng bagong sample o bangka?"),
          content: Text(
              "Naisumite na ang iyong tala. \n\nPiliin kung babalik ka sa Home Screen o magdadagdag ng isa pang sample o bangka. \n\nMangyaring pindutin ang labas pag nagkamali lang."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Bumalik sa Home Screen',
                  style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Magdagdag pa"),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
            )
          ],
        ),
      );

  Future<bool?> noTallyWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text("Wala ka pang \nnaidadagdag na isda"),
          content: Text(
              "Siguraduhing napindot ang 'IDAGDAG' para malista ang sinukat na isda"),
        ),
      );

  void _addSpeciesToList() {
    setState(() {
      species.insert(0, commonNameController.text);
      pic.insert(0, speciesPic);
      length.insert(0, lengthController.text);
      weight.insert(0, weightController.text);
    });
  }

  void _changeCommonToSciName() {
    if (commonNameController.text == "Flag-tailed glass perchlet (ning-ning)") {
      setState(() {
        speciesNameController.text = "Ambassis miops";
        speciesPic = 'assets/Ambassis miops.PNG';
      });
    } else if (commonNameController.text == "Midas cichlid (red tilapia)") {
      setState(() {
        speciesNameController.text = "Amphilophus citrinellus";
        speciesPic = 'assets/Amphilophus citrinellus.PNG';
      });
    } else if (commonNameController.text == "Climbing perch (martiniko)") {
      setState(() {
        speciesNameController.text = "Anabas testudineus";
        speciesPic = 'assets/Anabas testudineus.PNG';
      });
    } else if (commonNameController.text == "Giant mottled eel (igat)") {
      setState(() {
        speciesNameController.text = "Anguilla marmorata";
        speciesPic = 'assets/Anguilla marmorata.PNG';
      });
    } else if (commonNameController.text == "Manila sea catfish (kanduli)") {
      setState(() {
        speciesNameController.text = "Arius manillensis";
        speciesPic = 'assets/Arius manillensis.PNG';
      });
    } else if (commonNameController.text ==
        "Eendracht Land silverside (guno)") {
      setState(() {
        speciesNameController.text = "Atherinomorus endrachtensis";
        speciesPic = 'assets/Atherinomorus endrachtensis.PNG';
      });
    } else if (commonNameController.text == "Giant trevally (maliputo)") {
      setState(() {
        speciesNameController.text = "Caranx ignobilis";
        speciesPic = 'assets/Caranx ignobilis.PNG';
      });
    } else if (commonNameController.text == "Big-eye trevally (muslo)") {
      setState(() {
        speciesNameController.text = "Caranx sexfasciatus";
        speciesPic = 'assets/Caranx sexfasciatus.PNG';
      });
    } else if (commonNameController.text == "Crucian carp (karpita)") {
      setState(() {
        speciesNameController.text = "Carassius carassius";
        speciesPic = 'assets/Carassius carassius.PNG';
      });
    } else if (commonNameController.text == "Striped snakehead (dalag)") {
      setState(() {
        speciesNameController.text = "Channa striata";
        speciesPic = 'assets/Channa striata.PNG';
      });
    } else if (commonNameController.text == "Milkfish (bangus)") {
      setState(() {
        speciesNameController.text = "Chanos chanos";
        speciesPic = 'assets/Chanos chanos.PNG';
      });
    } else if (commonNameController.text == "Philippine catfish (hito)") {
      setState(() {
        speciesNameController.text = "Clarias batrachus";
        speciesPic = 'assets/Clarias batrachus.PNG';
      });
    } else if (commonNameController.text == "Bighead catfish (hito)") {
      setState(() {
        speciesNameController.text = "Clarias macrocephalus";
        speciesPic = 'assets/Clarias macrocephalus.PNG';
      });
    } else if (commonNameController.text == "Common carp (karpa)") {
      setState(() {
        speciesNameController.text = "Cyprinus carpio";
        speciesPic = 'assets/Cyprinus carpio.PNG';
      });
    } else if (commonNameController.text == "Pipefish (kambabalo)") {
      setState(() {
        speciesNameController.text = "Doryichthys martensii";
        speciesPic = 'assets/Doryichthys martensii.PNG';
      });
    } else if (commonNameController.text == "Tenpounder (Kanoping)") {
      setState(() {
        speciesNameController.text = "Elops machnata";
        speciesPic = 'assets/Elops machnata.PNG';
      });
    } else if (commonNameController.text == "Half-barred cardinal (dangat)") {
      setState(() {
        speciesNameController.text = "Fibramia thermalis";
        speciesPic = 'assets/Fibramia thermalis.PNG';
      });
    } else if (commonNameController.text ==
        "Whipfin silver-biddy (balabatuhan)") {
      setState(() {
        speciesNameController.text = "Gerres filamentosus";
        speciesPic = 'assets/Gerres filamentosus.PNG';
      });
    } else if (commonNameController.text == "Snakehead gudgeon (baculi)") {
      setState(() {
        speciesNameController.text = "Giuris margaritacea";
        speciesPic = 'assets/Giuris margaritacea.PNG';
      });
    } else if (commonNameController.text == "Celebes goby (biyang bato)") {
      setState(() {
        speciesNameController.text = "Glossogobius celebius";
        speciesPic = 'assets/Glossogobius celebius.PNG';
      });
    } else if (commonNameController.text == "Tank goby (biyang puti)") {
      setState(() {
        speciesNameController.text = "Glossogobius giuris";
        speciesPic = 'assets/Glossogobius giuris.PNG';
      });
    } else if (commonNameController.text == "Bighead carp (bighead)") {
      setState(() {
        speciesNameController.text = "Hypophthalmichthys nobilis";
        speciesPic = 'assets/Hypophthalmichthys nobilis.PNG';
      });
    } else if (commonNameController.text == "Quoy's garfish (siliw)") {
      setState(() {
        speciesNameController.text = "Hyporhamphus quoyi";
        speciesPic = 'assets/Hyporhamphus quoyi.PNG';
      });
    } else if (commonNameController.text == "Barramundi (apahap)") {
      setState(() {
        speciesNameController.text = "Lates calcarifer";
        speciesPic = 'assets/Lates calcarifer.PNG';
      });
    } else if (commonNameController.text == "Silver perch (ayungin)") {
      setState(() {
        speciesNameController.text = "Leiopotherapon plumbeus";
        speciesPic = 'assets/Leiopotherapon plumbeus.PNG';
      });
    } else if (commonNameController.text == "Mangrove red snapper (also)") {
      setState(() {
        speciesNameController.text = "Lutjanus argentimaculatus";
        speciesPic = 'assets/Lutjanus argentimaculatus.PNG';
      });
    } else if (commonNameController.text ==
        "Malabar blood snapper (maya-maya)") {
      setState(() {
        speciesNameController.text = "Lutjanus malabaricus";
        speciesPic = 'assets/Lutjanus malabaricus.PNG';
      });
    } else if (commonNameController.text == "Indo-Pacific tarpon (buan-buan)") {
      setState(() {
        speciesNameController.text = "Megalops cyprinoides";
        speciesPic = 'assets/Megalops cyprinoides.PNG';
      });
    } else if (commonNameController.text == "Sharptail goby (biya)") {
      setState(() {
        speciesNameController.text = "Oligolepis acutipennis";
        speciesPic = 'assets/Oligolepis acutipennis.PNG';
      });
    } else if (commonNameController.text == "Gossamer blenny (isdang mamay)") {
      setState(() {
        speciesNameController.text = "Omobranchus ferox";
        speciesPic = 'assets/Omobranchus ferox.PNG';
      });
    } else if (commonNameController.text == "Nile tilapia (tilapia)") {
      setState(() {
        speciesNameController.text = "Oreochromis niloticus";
        speciesPic = 'assets/Oreochromis niloticus.PNG';
      });
    } else if (commonNameController.text == "Striped catfish (pangasius)") {
      setState(() {
        speciesNameController.text = "Pangasianodon hypophthalmus";
        speciesPic = 'assets/Pangasianodon hypophthalmus.PNG';
      });
    } else if (commonNameController.text == "Jaguar guapote (dugong)") {
      setState(() {
        speciesNameController.text = "Parachromis managuensis";
        speciesPic = 'assets/Parachromis managuensis.PNG';
      });
    } else if (commonNameController.text == "Greenback mullet (Banak)") {
      setState(() {
        speciesNameController.text = "Planiliza subviridis";
        speciesPic = 'assets/Planiliza subviridis.PNG';
      });
    } else if (commonNameController.text == "Sleepy goby (biya)") {
      setState(() {
        speciesNameController.text = "Psammogobius biocellatus";
        speciesPic = 'assets/Psammogobius biocellatus.PNG';
      });
    } else if (commonNameController.text ==
        "Vermiculated sailfin catfish (janitor fish)") {
      setState(() {
        speciesNameController.text = "Pterygoplichthys disjunctivus";
        speciesPic = 'assets/Pterygoplichthys disjunctivus.PNG';
      });
    } else if (commonNameController.text == "Freshwater sardine (tawilis)") {
      setState(() {
        speciesNameController.text = "Sardinella tawilis";
        speciesPic = 'assets/Sardinella tawilis.PNG';
      });
    } else if (commonNameController.text ==
        "Blackchin tilapia (tilapiang arroyo)") {
      setState(() {
        speciesNameController.text = "Sarotherodon melanotheron";
        speciesPic = 'assets/Sarotherodon melanotheron.PNG';
      });
    } else if (commonNameController.text == "Spotted scat (kitang)") {
      setState(() {
        speciesNameController.text = "Scatophagus argus";
        speciesPic = 'assets/Scatophagus argus.PNG';
      });
    } else if (commonNameController.text == "Jarbua terapon (bagaong)") {
      setState(() {
        speciesNameController.text = "Terapon jarbua";
        speciesPic = 'assets/Terapon jarbua.PNG';
      });
    } else if (commonNameController.text == "Banded archerfish (kataba)") {
      setState(() {
        speciesNameController.text = "Toxotes jaculatrix";
        speciesPic = 'assets/Toxotes jaculatrix.PNG';
      });
    } else if (commonNameController.text == "Three spot gourami (gurami)") {
      setState(() {
        speciesNameController.text = "Trichopodus trichopterus";
        speciesPic = 'assets/Trichopodus trichopterus.PNG';
      });
    } else if (commonNameController.text == "Humpbacked cardinalfish (muang)") {
      setState(() {
        speciesNameController.text = "Yarica hyalosoma";
        speciesPic = 'assets/Yarica hyalosoma.PNG';
      });
    } else if (commonNameController.text == "Feathered river-garfish (siliw)") {
      setState(() {
        speciesNameController.text = "Zenarchopterus dispar";
        speciesPic = 'assets/Zenarchopterus dispar.PNG';
      });
    }
  }

  _addSpeciesAlert(
      context,
      passedDate,
      passedEnumerator,
      passedLandingCenter,
      passedFishingGround,
      passedTotalLandings,
      passedBoatName,
      passedFishingGear,
      passedFishingEffort,
      passedTotalBoatCatch,
      passedSampleSerialNumber,
      passedTotalSampleWeight) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => FormPreview(
              children: [
                Image.asset(speciesPic),
                Text("\nCommon Name ng Isda:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  "${commonNameController.text}",
                ),
                Text("\nScientific Name ng Isda:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${speciesNameController.text}",
                    style: TextStyle(fontStyle: FontStyle.italic)),
              ],
              onPressed: () async {
                bool isConnected =
                    await InternetConnectionChecker().hasConnection;
                if (isConnected == true) {
                  _postSpeciesOnline(
                      passedDate,
                      passedEnumerator,
                      passedLandingCenter,
                      passedFishingGround,
                      passedTotalLandings,
                      passedBoatName,
                      passedFishingGear,
                      passedFishingEffort,
                      passedTotalBoatCatch,
                      passedSampleSerialNumber,
                      passedTotalSampleWeight);
                  print('Is connedted :)');
                } else {
                  _postSpeciesOffline(
                      passedDate,
                      passedEnumerator,
                      passedLandingCenter,
                      passedFishingGround,
                      passedTotalLandings,
                      passedBoatName,
                      passedFishingGear,
                      passedFishingEffort,
                      passedTotalBoatCatch,
                      passedSampleSerialNumber,
                      passedTotalSampleWeight);
                  print('Not connected :(');
                }
              },
            ));
  }

  void _postSpeciesOnline(
      passedDate,
      passedEnumerator,
      passedLandingCenter,
      passedFishingGround,
      passedTotalLandings,
      passedBoatName,
      passedFishingGear,
      passedFishingEffort,
      passedTotalBoatCatch,
      passedSampleSerialNumber,
      passedTotalSampleWeight) async {
    _addSpeciesToList();
    showDialog(
        context: context,
        builder: (context) =>
            LoadingDialog(color: Colors.green, text: "Inu-upload"));
    await sleep();
    String? uuidNow;
    uuidNow = uuid.v4().toString();
    final passedGSheetsDate = DateFormat('yyyy/MM/dd').format(passedDate);
    final passedSqfliteDateTime = DateFormat('yyyy-MM-dd').format(passedDate);
    final feedback = {
      EnumeratorRawDataColumn.uuid: uuidNow.trim(),
      EnumeratorRawDataColumn.date: passedGSheetsDate.trim(),
      EnumeratorRawDataColumn.enumerator: passedEnumerator.trim(),
      EnumeratorRawDataColumn.landingCenter: passedLandingCenter.trim(),
      EnumeratorRawDataColumn.fishingGround: passedFishingGround.trim(),
      EnumeratorRawDataColumn.totalLandings: passedTotalLandings.trim(),
      EnumeratorRawDataColumn.boatName: passedBoatName.trim(),
      EnumeratorRawDataColumn.fishingGear: passedFishingGear.trim(),
      EnumeratorRawDataColumn.fishingEffort: passedFishingEffort.trim(),
      EnumeratorRawDataColumn.totalBoatCatch: passedTotalBoatCatch.trim(),
      EnumeratorRawDataColumn.sampleSerialNumber:
          passedSampleSerialNumber.trim(),
      EnumeratorRawDataColumn.totalSampleWeight: passedTotalSampleWeight.trim(),
      EnumeratorRawDataColumn.speciesName: speciesNameController.text.trim(),
      EnumeratorRawDataColumn.length: lengthController.text.trim(),
      EnumeratorRawDataColumn.weight: weightController.text.trim(),
    };
    print(feedback);
    await GoogleSheetsApi.insert([feedback]);
    await DatabaseHelperOne.instance.add(enumeratorLocal(
        uuid: uuidNow,
        date: passedSqfliteDateTime,
        enumerator: passedEnumerator,
        landingCenter: passedLandingCenter,
        fishingGround: passedFishingGround,
        totalLandings: passedTotalLandings,
        boatName: passedBoatName,
        fishingGear: passedFishingGear,
        fishingEffort: passedFishingEffort,
        totalBoatCatch: passedTotalBoatCatch,
        sampleSerialNumber: passedSampleSerialNumber,
        totalSampleWeight: passedTotalSampleWeight,
        speciesName: speciesNameController.text,
        commonName: commonNameController.text,
        length: lengthController.text,
        weight: weightController.text,
        image: speciesPic));
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _postSpeciesOffline(
      passedDate,
      passedEnumerator,
      passedLandingCenter,
      passedFishingGround,
      passedTotalLandings,
      passedBoatName,
      passedFishingGear,
      passedFishingEffort,
      passedTotalBoatCatch,
      passedSampleSerialNumber,
      passedTotalSampleWeight) async {
    _addSpeciesToList();
    String? uuidNow;
    uuidNow = uuid.v4().toString();
    final passedSqfliteDateTime = DateFormat('yyyy-MM-dd').format(passedDate);
    await DatabaseHelperTwo.instance.add(enumeratorOffline(
        uuid: uuidNow,
        date: passedSqfliteDateTime,
        enumerator: passedEnumerator,
        landingCenter: passedLandingCenter,
        fishingGround: passedFishingGround,
        totalLandings: passedTotalLandings,
        boatName: passedBoatName,
        fishingGear: passedFishingGear,
        fishingEffort: passedFishingEffort,
        totalBoatCatch: passedTotalBoatCatch,
        sampleSerialNumber: passedSampleSerialNumber,
        totalSampleWeight: passedTotalSampleWeight,
        speciesName: speciesNameController.text,
        commonName: commonNameController.text,
        length: lengthController.text,
        weight: weightController.text,
        image: speciesPic));
    Navigator.pop(context);
  }

  TextEditingController speciesNameController = TextEditingController();
  TextEditingController commonNameController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController weightController = TextEditingController();

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

  final listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Arguments;
    return WillPopScope(
        onWillPop: () async {
          print('Ikaw ay bumalik');
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                margin: EdgeInsets.all(20),
                child: RawScrollbar(
                  thumbColor: Color.fromARGB(139, 76, 175, 79),
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [Text('${args.passedDate}')]),
                                  Text('Nahuli sa ${args.passedFishingGround}'),
                                  Text(
                                      'Dumaong sa ${args.passedLandingCenter}'),
                                  Text(
                                      'Bangkang humuli: ${args.passedBoatName}'),
                                  Text(
                                      'Gear na panghuli: ${args.passedFishingGear}'),
                                  Text(
                                      'Sample Serial Number: ${args.passedSampleSerialNumber}'),
                                ]),
                            Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Mga Isdang Sinukat',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                    FaIcon(FontAwesomeIcons.fish)
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: Color.fromARGB(61, 0, 0, 0),
                                          width: 1.7)),
                                  height: 160,
                                  child: RawScrollbar(
                                    thumbColor: Colors.green,
                                    child: AnimatedList(
                                        key: listKey,
                                        padding: const EdgeInsets.only(
                                            top: 0, bottom: 5),
                                        initialItemCount: species.length,
                                        itemBuilder: (BuildContext context,
                                            int index, animation) {
                                          return Card(
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: ListTile(
                                                leading: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${species[index]}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(
                                                          "Haba: ${length[index]} cm     Bigat: ${weight[index]} g")
                                                    ],
                                                  ),
                                                ),
                                                trailing: Image.asset(
                                                    '${pic[index]}',
                                                    width: 60),
                                              ));
                                        }),
                                  )),
                            ),
                            Form(
                                key: _formKeyTwo,
                                child: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Column(
                                      children: [
                                        DropDownField(
                                          items: [
                                            "Flag-tailed glass perchlet (ning-ning)",
                                            "Midas cichlid (red tilapia)",
                                            "Climbing perch (martiniko)",
                                            "Giant mottled eel (igat)",
                                            "Manila sea catfish (kanduli)",
                                            "Eendracht Land silverside (guno)",
                                            "Giant trevally (maliputo)",
                                            "Big-eye trevally (muslo)",
                                            "Crucian carp (karpita)",
                                            "Striped snakehead (dalag)",
                                            "Milkfish (bangus)",
                                            "Philippine catfish (hito)",
                                            "Bighead catfish (hito)",
                                            "Common carp (karpa)",
                                            "Pipefish (kambabalo)",
                                            "Tenpounder (Kanoping)",
                                            "Half-barred cardinal (dangat)",
                                            "Whipfin silver-biddy (balabatuhan)",
                                            "Snakehead gudgeon (baculi)",
                                            "Celebes goby (biyang bato)",
                                            "Tank goby (biyang puti)",
                                            "Bighead carp (bighead)",
                                            "Quoy's garfish (siliw)",
                                            "Barramundi (apahap)",
                                            "Silver perch (ayungin)",
                                            "Mangrove red snapper (also)",
                                            "Malabar blood snapper (maya-maya)",
                                            "Indo-Pacific tarpon (buan-buan)",
                                            "Sharptail goby (biya)",
                                            "Gossamer blenny (isdang mamay)",
                                            "Nile tilapia (tilapia)",
                                            "Striped catfish (pangasius)",
                                            "Jaguar guapote (dugong)",
                                            "Greenback mullet (Banak)",
                                            "Sleepy goby (biya)",
                                            "Vermiculated sailfin catfish (janitor fish)",
                                            "Freshwater sardine (tawilis)",
                                            "Blackchin tilapia (tilapiang arroyo)",
                                            "Spotted scat (kitang)",
                                            "Jarbua terapon (bagaong)",
                                            "Banded archerfish (kataba)",
                                            "Three spot gourami (gurami)",
                                            "Humpbacked cardinalfish (muang)",
                                            "Feathered river-garfish (siliw)"
                                          ],
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Walang sagot; pumili ng isda';
                                            }
                                            return null;
                                          },
                                          labelTextOne: "Pangalan ng Isda",
                                          labelTextTwo:
                                              "Hanapin ang Isdang Sinukat",
                                          labelTextThree: 'Pangalan ng Isda',
                                          onChanged: (String? value) {
                                            setState(() {
                                              commonNameController.text =
                                                  value!;
                                            });
                                            _changeCommonToSciName();
                                          },
                                        ),
                                        TextInputField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Walang sagot; ilagay ang haba ng isda';
                                              }
                                              return null;
                                            },
                                            controller: lengthController,
                                            labelText: "Haba ng Isda (cm)",
                                            keyboardType: TextInputType.number),
                                        TextInputField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Walang sagot; ilagay ang bigat ng isda';
                                              }
                                              return null;
                                            },
                                            controller: weightController,
                                            labelText: "Bigat ng Isda (g)",
                                            keyboardType: TextInputType.number),
                                      ],
                                    ))),
                            AddButton(
                                icon: FaIcon(FontAwesomeIcons.plusCircle,
                                    color: Colors.white),
                                text: 'IDAGDAG',
                                function: () {
                                  if (_formKeyTwo.currentState!.validate()) {
                                    _addSpeciesAlert(
                                        context,
                                        args.passedDate,
                                        args.passedEnumerator,
                                        args.passedLandingCenter,
                                        args.passedFishingGround,
                                        args.passedTotalLandings,
                                        args.passedBoatName,
                                        args.passedFishingGear,
                                        args.passedFishingEffort,
                                        args.passedTotalBoatCatch,
                                        args.passedSampleSerialNumber,
                                        args.passedTotalSampleWeight);
                                  } else {
                                    showTopSnackBar(
                                        context,
                                        CustomSnackBar.error(
                                          message:
                                              "May kulang pa sa iyong tala. I-double check kung may laman na lahat.",
                                        ));
                                  }
                                }),
                            Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: SubmitButton(
                                    icon: Icon(Icons.send, color: Colors.white),
                                    text: 'ISUMITE',
                                    function: () {
                                      if (_formKeyTwo.currentState!
                                          .validate()) {
                                        if (species.length < 1) {
                                          noTallyWarning(context);
                                        } else {
                                          showAddQuestion(context);
                                          setState(() {});
                                        }
                                      } else {
                                        showTopSnackBar(
                                            context,
                                            CustomSnackBar.error(
                                              message:
                                                  "May kulang pa sa iyong tala. I-double check kung may laman na lahat.",
                                            ));
                                      }
                                    }))
                          ])),
                ))));
  }

  Future sleep() {
    return new Future.delayed(const Duration(milliseconds: 500), () => "1");
  }
}
