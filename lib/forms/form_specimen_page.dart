import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:smart_taal_system/backend/enumeratorRawData.dart';
import 'package:smart_taal_system/backend/google_sheets_api.dart';
import 'package:smart_taal_system/backend/sqlfite_local_secondary_db.dart';
import 'package:smart_taal_system/submit_button.dart';
import '../backend/sqlfite_local_primary_db.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class NewSpecies extends StatefulWidget {
  final Function(String) addSpecies;
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
      required this.addSpecies,
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
  String commonName = '';
  String speciesPic = '';

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
                setState(() {});
              },
              child: Text('Bumalik sa Home Screen',
                  style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                //int count = 0;
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
      species.insert(0, commonName);
      pic.insert(0, speciesPic);
      length.insert(0, lengthController.text);
      weight.insert(0, weightController.text);
    });
  }

  void _changeCommonToSciName() {
    if (commonName == "Flag-tailed glass perchlet (ning-ning)") {
      setState(() {
        speciesNameController.text = "Ambassis miops";
        speciesPic = 'assets/Ambassis miops.PNG';
      });
    } else if (commonName == "Midas cichlid (red tilapia)") {
      setState(() {
        speciesNameController.text = "Amphilophus citrinellus";
        speciesPic = 'assets/Amphilophus citrinellus.PNG';
      });
    } else if (commonName == "Climbing perch (martiniko)") {
      setState(() {
        speciesNameController.text = "Anabas testudineus";
        speciesPic = 'assets/Anabas testudineus.PNG';
      });
    } else if (commonName == "Giant mottled eel (igat)") {
      setState(() {
        speciesNameController.text = "Anguilla marmorata";
        speciesPic = 'assets/Anguilla marmorata.PNG';
      });
    } else if (commonName == "Manila sea catfish (kanduli)") {
      setState(() {
        speciesNameController.text = "Arius manillensis";
        speciesPic = 'assets/Arius manillensis.PNG';
      });
    } else if (commonName == "Eendracht Land silverside (guno)") {
      setState(() {
        speciesNameController.text = "Atherinomorus endrachtensis";
        speciesPic = 'assets/Atherinomorus endrachtensis.PNG';
      });
    } else if (commonName == "Giant trevally (maliputo)") {
      setState(() {
        speciesNameController.text = "Caranx ignobilis";
        speciesPic = 'assets/Caranx ignobilis.PNG';
      });
    } else if (commonName == "Big-eye trevally (muslo)") {
      setState(() {
        speciesNameController.text = "Caranx sexfasciatus";
        speciesPic = 'assets/Caranx sexfasciatus.PNG';
      });
    } else if (commonName == "Crucian carp (karpita)") {
      setState(() {
        speciesNameController.text = "Carassius carassius";
        speciesPic = 'assets/Carassius carassius.PNG';
      });
    } else if (commonName == "Striped snakehead (dalag)") {
      setState(() {
        speciesNameController.text = "Channa striata";
        speciesPic = 'assets/Channa striata.PNG';
      });
    } else if (commonName == "Milkfish (bangus)") {
      setState(() {
        speciesNameController.text = "Chanos chanos";
        speciesPic = 'assets/Chanos chanos.PNG';
      });
    } else if (commonName == "Philippine catfish (hito)") {
      setState(() {
        speciesNameController.text = "Clarias batrachus";
        speciesPic = 'assets/Clarias batrachus.PNG';
      });
    } else if (commonName == "Bighead catfish (hito)") {
      setState(() {
        speciesNameController.text = "Clarias macrocephalus";
        speciesPic = 'assets/Clarias macrocephalus.PNG';
      });
    } else if (commonName == "Common carp (karpa)") {
      setState(() {
        speciesNameController.text = "Cyprinus carpio";
        speciesPic = 'assets/Cyprinus carpio.PNG';
      });
    } else if (commonName == "Pipefish (kambabalo)") {
      setState(() {
        speciesNameController.text = "Doryichthys martensii";
        speciesPic = 'assets/Doryichthys martensii.PNG';
      });
    } else if (commonName == "Tenpounder (Kanoping)") {
      setState(() {
        speciesNameController.text = "Elops machnata";
        speciesPic = 'assets/Elops machnata.PNG';
      });
    } else if (commonName == "Half-barred cardinal (dangat)") {
      setState(() {
        speciesNameController.text = "Fibramia thermalis";
        speciesPic = 'assets/Fibramia thermalis.PNG';
      });
    } else if (commonName == "Whipfin silver-biddy (balabatuhan)") {
      setState(() {
        speciesNameController.text = "Gerres filamentosus";
        speciesPic = 'assets/Gerres filamentosus.PNG';
      });
    } else if (commonName == "Snakehead gudgeon (baculi)") {
      setState(() {
        speciesNameController.text = "Giuris margaritacea";
        speciesPic = 'assets/Giuris margaritacea.PNG';
      });
    } else if (commonName == "Celebes goby (biyang bato)") {
      setState(() {
        speciesNameController.text = "Glossogobius celebius";
        speciesPic = 'assets/Glossogobius celebius.PNG';
      });
    } else if (commonName == "Tank goby (biyang puti)") {
      setState(() {
        speciesNameController.text = "Glossogobius giuris";
        speciesPic = 'assets/Glossogobius giuris.PNG';
      });
    } else if (commonName == "Bighead carp (bighead)") {
      setState(() {
        speciesNameController.text = "Hypophthalmichthys nobilis";
        speciesPic = 'assets/Hypophthalmichthys nobilis.PNG';
      });
    } else if (commonName == "Quoy's garfish (siliw)") {
      setState(() {
        speciesNameController.text = "Hyporhamphus quoyi";
        speciesPic = 'assets/Hyporhamphus quoyi.PNG';
      });
    } else if (commonName == "Barramundi (apahap)") {
      setState(() {
        speciesNameController.text = "Lates calcarifer";
        speciesPic = 'assets/Lates calcarifer.PNG';
      });
    } else if (commonName == "Silver perch (ayungin)") {
      setState(() {
        speciesNameController.text = "Leiopotherapon plumbeus";
        speciesPic = 'assets/Leiopotherapon plumbeus.PNG';
      });
    } else if (commonName == "Mangrove red snapper (also)") {
      setState(() {
        speciesNameController.text = "Lutjanus argentimaculatus";
        speciesPic = 'assets/Lutjanus argentimaculatuss.PNG';
      });
    } else if (commonName == "Malabar blood snapper (maya-maya)") {
      setState(() {
        speciesNameController.text = "Lutjanus malabaricus";
        speciesPic = 'assets/Lutjanus malabaricus.PNG';
      });
    } else if (commonName == "Indo-Pacific tarpon (buan-buan)") {
      setState(() {
        speciesNameController.text = "Megalops cyprinoides";
        speciesPic = 'assets/Megalops cyprinoides.PNG';
      });
    } else if (commonName == "Sharptail goby (biya)") {
      setState(() {
        speciesNameController.text = "Oligolepis acutipennis";
        speciesPic = 'assets/Oligolepis acutipennis.PNG';
      });
    } else if (commonName == "Gossamer blenny (isdang mamay)") {
      setState(() {
        speciesNameController.text = "Omobranchus ferox";
        speciesPic = 'assets/Omobranchus ferox.PNG';
      });
    } else if (commonName == "Nile tilapia (tilapia)") {
      setState(() {
        speciesNameController.text = "Oreochromis niloticus";
        speciesPic = 'assets/Oreochromis niloticus.PNG';
      });
    } else if (commonName == "Striped catfish (pangasius)") {
      setState(() {
        speciesNameController.text = "Pangasianodon hypophthalmus";
        speciesPic = 'assets/Pangasianodon hypophthalmus.PNG';
      });
    } else if (commonName == "Jaguar guapote (dugong)") {
      setState(() {
        speciesNameController.text = "Parachromis managuensis";
        speciesPic = 'assets/Parachromis managuensis.PNG';
      });
    } else if (commonName == "Greenback mullet (Banak)") {
      setState(() {
        speciesNameController.text = "Planiliza subviridis";
        speciesPic = 'assets/Planiliza subviridis.PNG';
      });
    } else if (commonName == "Sleepy goby (biya)") {
      setState(() {
        speciesNameController.text = "Psammogobius biocellatus";
        speciesPic = 'assets/Psammogobius biocellatus.PNG';
      });
    } else if (commonName == "Vermiculated sailfin catfish (janitor fish)") {
      setState(() {
        speciesNameController.text = "Pterygoplichthys disjunctivus";
        speciesPic = 'assets/Pterygoplichthys disjunctivus.PNG';
      });
    } else if (commonName == "Freshwater sardine (tawilis)") {
      setState(() {
        speciesNameController.text = "Sardinella tawilis";
        speciesPic = 'assets/Sardinella tawilis.PNG';
      });
    } else if (commonName == "Blackchin tilapia (tilapiang arroyo)") {
      setState(() {
        speciesNameController.text = "Sarotherodon melanotheron";
        speciesPic = 'assets/Sarotherodon melanotheron.PNG';
      });
    } else if (commonName == "Spotted scat (kitang)") {
      setState(() {
        speciesNameController.text = "Scatophagus argus";
        speciesPic = 'assets/Scatophagus argus.PNG';
      });
    } else if (commonName == "Jarbua terapon (bagaong)") {
      setState(() {
        speciesNameController.text = "Terapon jarbua";
        speciesPic = 'assets/Terapon jarbua.PNG';
      });
    } else if (commonName == "Banded archerfish (kataba)") {
      setState(() {
        speciesNameController.text = "Toxotes jaculatrix";
        speciesPic = 'assets/Toxotes jaculatrix.PNG';
      });
    } else if (commonName == "Three spot gourami (gurami)") {
      setState(() {
        speciesNameController.text = "Trichopodus trichopterus";
        speciesPic = 'assets/Trichopodus trichopterus.PNG';
      });
    } else if (commonName == "Humpbacked cardinalfish (muang)") {
      setState(() {
        speciesNameController.text = "Yarica hyalosoma";
        speciesPic = 'assets/Yarica hyalosoma.PNG';
      });
    } else if (commonName == "Feathered river-garfish (siliw)") {
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
                            Text("\nCommon Name ng Isda: \n${commonName}",
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
                  onPressed: _postSpecies,
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

  void _postSpecies() async {
    _addSpeciesToList();

    final passedGSheetsDate =
        DateFormat('yyyy/MM/dd').format(widget.passedDate);
    final passedSqfliteDateTime =
        DateFormat('dd/MM/yyyy h:mma').format(widget.passedDate);
    final passedSqfliteDate =
        DateFormat('dd/MM/yyyy').format(widget.passedDate);
    final feedback = {
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
    await GoogleSheetsApi.insert([feedback]);
    await DatabaseHelperOne.instance.add(enumeratorLocal(
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
        length: lengthController.text,
        weight: weightController.text,
        image: speciesPic));
    await DatabaseHelperTwo.instance.add(enumeratorDays(
      date: passedSqfliteDate,
      enumerator: widget.passedEnumerator,
      landingCenter: widget.passedLandingCenter,
      fishingGround: widget.passedFishingGround,
      totalLandings: widget.passedTotalLandings,
    ));
    Navigator.of(context).pop();
    setState(() {});
  }

  TextEditingController dateController = TextEditingController();
  TextEditingController enumeratorController = TextEditingController();
  TextEditingController landingCenterController = TextEditingController();
  TextEditingController fishingGroundController = TextEditingController();
  TextEditingController boatNameController = TextEditingController();
  TextEditingController fishingGearController = TextEditingController();
  TextEditingController fishingEffortController = TextEditingController();
  TextEditingController totalBoatCatchController = TextEditingController();
  TextEditingController sampleSerialNumberController = TextEditingController();
  TextEditingController totalSampleWeightController = TextEditingController();
  TextEditingController speciesNameController = TextEditingController();
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
                                        commonName = value!;
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
