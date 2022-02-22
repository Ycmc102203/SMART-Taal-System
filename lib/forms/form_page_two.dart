import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/backend/enumeratorRawData.dart';
import 'package:smart_taal_system/backend/google_sheets_api.dart';
import 'package:smart_taal_system/backend/sqlfite_local_offline_cache.dart';

import 'package:smart_taal_system/submit_button.dart';
import 'package:uuid/uuid.dart';
import '../backend/sqlfite_local_primary_db.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'package:flutter_offline/flutter_offline.dart';

class NewSpecies extends StatefulWidget {
  final DateTime passedDate;
  final String passedEnumerator;
  final String passedFishingGround;
  final String passedLandingCenter;
  final String passedTotalLandings;
  final String passedBoatName;
  final String passedFishingGear;
  final String passedFishingEffort;
  final String passedTotalBoatCatch;
  final String passedSampleSerialNumber;
  final String passedTotalSampleWeight;

  const NewSpecies(
      {Key,
      key,
      required this.passedDate,
      required this.passedEnumerator,
      required this.passedFishingGround,
      required this.passedLandingCenter,
      required this.passedTotalLandings,
      required this.passedBoatName,
      required this.passedFishingGear,
      required this.passedFishingEffort,
      required this.passedTotalBoatCatch,
      required this.passedSampleSerialNumber,
      required this.passedTotalSampleWeight})
      : super(key: key);

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
                print('test!');
                setState(() {});
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                setState(() {});
              },
              child: Text('Bumalik sa Home Screen',
                  style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                print('test!');
                setState(() {});
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

  _addSpeciesAlert(context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Text("Sigurado ka na ba sa mga nilagay mo?"),
              content: Scrollbar(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Bago magpatuloy sa pagtala ng mga nahuling isda, siguraduhing tama ang mga detalye ukol sa pagtatalang ito"),
                    Divider(
                      thickness: 3,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(speciesPic),
                            Text(
                                "\nScientific Name ng Isda: \n${speciesNameController.text}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                                "\nCommon Name ng Isda: \n${commonNameController.text}",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ))
                  ],
                ),
              )),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Bumalik'),
                  child: Text('Bumalik', style: TextStyle(color: Colors.green)),
                ),
                TextButton(
                  onPressed: () async {
                    bool isConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (isConnected == true) {
                      _postSpeciesOnline();
                      print('Is connedted :)');
                    } else {
                      _postSpeciesOffline();
                      print('Not connected :(');
                    }
                  },
                  child: Text("Oo, sigurado na ako"),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.green,
                    //onSurface: Colors.grey,
                  ),
                ),
              ],
            ));
  }

  void _postSpeciesOnline() async {
    _addSpeciesToList();
    String? uuidNow;
    uuidNow = uuid.v4().toString();
    final passedGSheetsDate =
        DateFormat('yyyy/MM/dd').format(widget.passedDate);
    final passedSqfliteDateTime =
        DateFormat('yyyy-MM-dd').format(widget.passedDate);
    final feedback = {
      EnumeratorRawDataColumn.uuid: uuidNow.trim(),
      EnumeratorRawDataColumn.date: passedGSheetsDate.trim(),
      EnumeratorRawDataColumn.enumerator: widget.passedEnumerator.trim(),
      EnumeratorRawDataColumn.landingCenter: widget.passedLandingCenter.trim(),
      EnumeratorRawDataColumn.fishingGround: widget.passedFishingGround.trim(),
      EnumeratorRawDataColumn.totalLandings: widget.passedTotalLandings.trim(),
      EnumeratorRawDataColumn.boatName: widget.passedBoatName.trim(),
      EnumeratorRawDataColumn.fishingGear: widget.passedFishingGear.trim(),
      EnumeratorRawDataColumn.fishingEffort: widget.passedFishingEffort.trim(),
      EnumeratorRawDataColumn.totalBoatCatch:
          widget.passedTotalBoatCatch.trim(),
      EnumeratorRawDataColumn.sampleSerialNumber:
          widget.passedSampleSerialNumber.trim(),
      EnumeratorRawDataColumn.totalSampleWeight:
          widget.passedTotalSampleWeight.trim(),
      EnumeratorRawDataColumn.speciesName: speciesNameController.text.trim(),
      EnumeratorRawDataColumn.length: lengthController.text.trim(),
      EnumeratorRawDataColumn.weight: weightController.text.trim(),
    };
    print(feedback);
    await GoogleSheetsApi.insert([feedback]);
    await DatabaseHelperOne.instance.add(enumeratorLocal(
        uuid: uuidNow,
        date: passedSqfliteDateTime,
        enumerator: widget.passedEnumerator,
        landingCenter: widget.passedLandingCenter,
        fishingGround: widget.passedFishingGround,
        totalLandings: widget.passedTotalLandings,
        boatName: widget.passedBoatName,
        fishingGear: widget.passedFishingGear,
        fishingEffort: widget.passedFishingEffort,
        totalBoatCatch: widget.passedTotalBoatCatch,
        sampleSerialNumber: widget.passedSampleSerialNumber,
        totalSampleWeight: widget.passedTotalSampleWeight,
        speciesName: speciesNameController.text,
        commonName: commonNameController.text,
        length: lengthController.text,
        weight: weightController.text,
        image: speciesPic));
    Navigator.of(context).pop();
    setState(() {});
  }

  void _postSpeciesOffline() async {
    _addSpeciesToList();
    String? uuidNow;
    uuidNow = uuid.v4().toString();
    final passedSqfliteDateTime =
        DateFormat('yyyy-MM-dd').format(widget.passedDate);
    await DatabaseHelperTwo.instance.add(enumeratorOffline(
        uuid: uuidNow,
        date: passedSqfliteDateTime,
        enumerator: widget.passedEnumerator,
        landingCenter: widget.passedLandingCenter,
        fishingGround: widget.passedFishingGround,
        totalLandings: widget.passedTotalLandings,
        boatName: widget.passedBoatName,
        fishingGear: widget.passedFishingGear,
        fishingEffort: widget.passedFishingEffort,
        totalBoatCatch: widget.passedTotalBoatCatch,
        sampleSerialNumber: widget.passedSampleSerialNumber,
        totalSampleWeight: widget.passedTotalSampleWeight,
        speciesName: speciesNameController.text,
        commonName: commonNameController.text,
        length: lengthController.text,
        weight: weightController.text,
        image: speciesPic));
    await DatabaseHelperOne.instance.add(enumeratorLocal(
        uuid: uuidNow,
        date: passedSqfliteDateTime,
        enumerator: widget.passedEnumerator,
        landingCenter: widget.passedLandingCenter,
        fishingGround: widget.passedFishingGround,
        totalLandings: widget.passedTotalLandings,
        boatName: widget.passedBoatName,
        fishingGear: widget.passedFishingGear,
        fishingEffort: widget.passedFishingEffort,
        totalBoatCatch: widget.passedTotalBoatCatch,
        sampleSerialNumber: widget.passedSampleSerialNumber,
        totalSampleWeight: widget.passedTotalSampleWeight,
        speciesName: speciesNameController.text,
        commonName: commonNameController.text,
        length: lengthController.text,
        weight: weightController.text,
        image: speciesPic));
    Navigator.of(context).pop();
    setState(() {});
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

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        print('Ikaw ay bumalik');
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [Text('${widget.passedDate}')]),
                            Text('Nahuli sa ${widget.passedFishingGround}'),
                            Text('Dumaong sa ${widget.passedLandingCenter}'),
                            Text('Bangkang humuli: ${widget.passedBoatName}'),
                            Text(
                                'Gear na panghuli: ${widget.passedFishingGear}'),
                            Text(
                                'Sample Serial Number: ${widget.passedSampleSerialNumber}'),
                          ]),
                      Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              child: ListView.builder(
                                  padding:
                                      const EdgeInsets.only(top: 0, bottom: 5),
                                  itemCount: species.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ListTile(
                                          leading: Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${species[index]}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                    "Haba: ${length[index]} cm     Bigat: ${weight[index]} g")
                                              ],
                                            ),
                                          ),
                                          trailing: Image.asset('${pic[index]}',
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
                                  DropdownSearch<String>(
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
                                      if (value == null || value.isEmpty) {
                                        return 'Walang sagot; pumili ng isda';
                                      }
                                      return null;
                                    },
                                    mode: Mode.DIALOG,
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: "Pangalan ng Isda",
                                      labelStyle: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 0, 0),
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (String? value) {
                                      setState(() {
                                        commonNameController.text = value!;
                                      });
                                      _changeCommonToSciName();
                                    },
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.search),
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(12, 12, 8, 0),
                                        labelText: "Hanapin ang Isdang Sinukat",
                                      ),
                                    ),
                                    popupTitle: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 60, 136, 63),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Pangalan ng Isda',
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
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Walang sagot; ilagay ang haba ng isda';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: lengthController,
                                    decoration: InputDecoration(
                                      labelText: "Haba ng Isda (cm)",
                                      labelStyle: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    maxLength: 4,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Walang sagot; ilagay ang bigat ng Isda';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: weightController,
                                    decoration: InputDecoration(
                                      labelText: "Bigat ng Isda (g)",
                                      labelStyle: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    maxLength: 6,
                                  ),
                                ],
                              ))),
                      TextButton(
                        onPressed: () {
                          if (_formKeyTwo.currentState!.validate()) {
                            _addSpeciesAlert(context);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2.2,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 4), // changes position of shadow
                              ),
                            ],
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "IDAGDAG",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: FaIcon(FontAwesomeIcons.plusCircle,
                                        color: Colors.white)),
                              ]),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 60),
                          child: SubmitButton(
                              icon: Icon(Icons.send, color: Colors.white),
                              text: 'ISUMITE',
                              function: () {
                                if (_formKeyTwo.currentState!.validate()) {
                                  if (species.length < 1) {
                                    noTallyWarning(context);
                                  } else {
                                    showAddQuestion(context);
                                    setState(() {});
                                  }
                                }
                              }))
                    ])),
          )));
}
