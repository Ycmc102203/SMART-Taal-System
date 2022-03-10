import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smart_taal_system/backend/sqlfite_local_primary_db.dart';
import 'package:smart_taal_system/forms/input/arguments.dart';
import 'package:smart_taal_system/forms/output/stored_form.dart';
import 'package:smart_taal_system/widgets/buttons/add_button.dart';

import '../../widgets/buttons/submit_button.dart';

showStoredFormForDate(
  BuildContext context,
  Future<List<enumeratorLocal>> speciesName,
  String dateSelectedString,
) {
  String englishFilipinoName = '';
  DateTime dateSelected = DateTime.parse(dateSelectedString);
  DateTime dateNow =
      DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  if (speciesName == 'Ambassis miops') {
    englishFilipinoName = 'Flag-tailed glass perchlet (ning-ning)';
  } else if (speciesName == 'Amphilophus citrinellus') {
    englishFilipinoName = 'Midas cichlid (red tilapia)';
  }
  if (speciesName == 'Ambassis miops') {
    englishFilipinoName = 'Flag-tailed glass perchlet (ning-ning)';
  } else if (speciesName == 'Amphilophus citrinellus') {
    englishFilipinoName = 'Midas cichlid (red tilapia)';
  } else if (speciesName == 'Anabas testudineus') {
    englishFilipinoName = 'Climbing perch (martiniko)';
  } else if (speciesName == 'Anguilla marmorata') {
    englishFilipinoName = 'Giant mottled eel (igat)';
  } else if (speciesName == 'Arius manillensis') {
    englishFilipinoName = 'Manila sea catfish (kanduli)';
  } else if (speciesName == 'Atherinomorus endrachtensis') {
    englishFilipinoName = 'Eendracht Land silverside (guno)';
  } else if (speciesName == 'Caranx ignobilis') {
    englishFilipinoName = 'Giant trevally (maliputo)';
  } else if (speciesName == 'Caranx sexfasciatus') {
    englishFilipinoName = 'Big-eye trevally (muslo)';
  } else if (speciesName == 'Carassius carassius') {
    englishFilipinoName = 'Crucian carp (karpita)';
  } else if (speciesName == 'Channa striata') {
    englishFilipinoName = 'Striped snakehead (dalag)';
  } else if (speciesName == 'Chanos chanos') {
    englishFilipinoName = 'Milkfish (bangus)';
  } else if (speciesName == 'Clarias batrachus') {
    englishFilipinoName = 'Philippine catfish (hito)';
  } else if (speciesName == 'Clarias macrocephalus') {
    englishFilipinoName = 'Bighead catfish (hito)';
  } else if (speciesName == 'Cyprinus carpio') {
    englishFilipinoName = 'Common carp (karpa)';
  } else if (speciesName == 'Doryichthys martensii') {
    englishFilipinoName = 'Pipefish (kambabalo)';
  } else if (speciesName == 'Elops machnata') {
    englishFilipinoName = 'Tenpounder (Kanoping)';
  } else if (speciesName == 'Fibramia thermalis') {
    englishFilipinoName = 'Half-barred cardinal (dangat)';
  } else if (speciesName == 'Gerres filamentosus') {
    englishFilipinoName = 'Whipfin silver-biddy (balabatuhan)';
  } else if (speciesName == 'Giuris margaritacea') {
    englishFilipinoName = 'Snakehead gudgeon (baculi)';
  } else if (speciesName == 'Glossogobius celebius') {
    englishFilipinoName = 'Celebes goby (biyang bato)';
  } else if (speciesName == 'Glossogobius giuris') {
    englishFilipinoName = 'Tank goby (biyang puti)';
  } else if (speciesName == 'Hypophthalmichthys nobilis') {
    englishFilipinoName = 'Bighead carp (bighead)';
  } else if (speciesName == 'Hyporhamphus quoyi') {
    englishFilipinoName = 'Quoy`s garfish (siliw)';
  } else if (speciesName == 'Lates calcarifer') {
    englishFilipinoName = 'Barramundi (apahap)';
  } else if (speciesName == 'Leiopotherapon plumbeus') {
    englishFilipinoName = 'Silver perch (ayungin)';
  } else if (speciesName == 'Lutjanus argentimaculatus') {
    englishFilipinoName = 'Mangrove red snapper (also)';
  } else if (speciesName == 'Lutjanus malabaricus') {
    englishFilipinoName = 'Malabar blood snapper (maya-maya)';
  } else if (speciesName == 'Megalops cyprinoides') {
    englishFilipinoName = 'Indo-Pacific tarpon (buan-buan)';
  } else if (speciesName == 'Oligolepis acutipennis') {
    englishFilipinoName = 'Sharptail goby (biya)';
  } else if (speciesName == 'Omobranchus ferox') {
    englishFilipinoName = 'Gossamer blenny (isdang mamay)';
  } else if (speciesName == 'Oreochromis niloticus') {
    englishFilipinoName = 'Nile tilapia (tilapia)';
  } else if (speciesName == 'Pangasianodon hypophthalmus') {
    englishFilipinoName = 'Striped catfish (pangasius)';
  } else if (speciesName == 'Parachromis managuensis') {
    englishFilipinoName = 'Jaguar guapote (dugong)';
  } else if (speciesName == 'Planiliza subviridis') {
    englishFilipinoName = 'Greenback mullet (Banak)';
  } else if (speciesName == 'Psammogobius biocellatus') {
    englishFilipinoName = 'Sleepy goby (biya)';
  } else if (speciesName == 'Pterygoplichthys disjunctivus') {
    englishFilipinoName = 'Vermiculated sailfin catfish (janitor fish)';
  } else if (speciesName == 'Sardinella tawilis') {
    englishFilipinoName = 'Freshwater sardine (tawilis)';
  } else if (speciesName == 'Sarotherodon melanotheron') {
    englishFilipinoName = 'Blackchin tilapia (tilapiang arroyo)';
  } else if (speciesName == 'Scatophagus argus') {
    englishFilipinoName = 'Spotted scat (kitang)';
  } else if (speciesName == 'Terapon jarbua') {
    englishFilipinoName = 'Jarbua terapon (bagaong)';
  } else if (speciesName == 'Toxotes jaculatrix') {
    englishFilipinoName = 'Banded archerfish (kataba)';
  } else if (speciesName == 'Trichopodus trichopterus') {
    englishFilipinoName = 'Three spot gourami (gurami)';
  } else if (speciesName == 'Yarica hyalosoma') {
    englishFilipinoName = 'Humpbacked cardinalfish (muang)';
  } else if (speciesName == 'Zenarchopterus dispar') {
    englishFilipinoName = 'Feathered river-garfish (siliw)';
  }
  ;

  var alert = AlertDialog(
      contentPadding: EdgeInsets.all(10),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FutureBuilder<List<enumeratorLocal>>(
                    future: speciesName,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<enumeratorLocal>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Text('Loading...'));
                      }
                      if (dateSelected.isAfter(dateNow)) {
                        return Center(
                          child: Text(
                              'Wala ka pang maitatala sapagkat di pa ito nakalilipas',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30)),
                        );
                      }
                      return snapshot.data!.isEmpty
                          ? Center(
                              child: Text(
                                  'Magtala ng Bagong Aktibidad para sa Araw na ito?',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30)),
                            )
                          : Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                    "Mga Natalang Isda         ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 24)),
                                                FaIcon(
                                                  FontAwesomeIcons.fish,
                                                  size: 20,
                                                  color: Colors.green,
                                                )
                                              ]))),
                                  Text('    sa araw ng:   ' +
                                      dateSelectedString),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                    ),
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: RefreshIndicator(
                                        onRefresh: () {
                                          return Future.delayed(
                                              Duration(seconds: 1), () {
                                            //setState(() {});
                                          });
                                        },
                                        child: RawScrollbar(
                                            thumbColor: Colors.green,
                                            radius: Radius.circular(10),
                                            thickness: 7,
                                            child: SingleChildScrollView(
                                                physics: BouncingScrollPhysics(
                                                    parent:
                                                        AlwaysScrollableScrollPhysics()),
                                                child: ListView(
                                                  reverse: true,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  children: snapshot.data!
                                                      .map((enumeratorLocal) {
                                                    return Center(
                                                        child:
                                                            FractionallySizedBox(
                                                                widthFactor:
                                                                    0.95,
                                                                child: Card(
                                                                    elevation:
                                                                        8,
                                                                    margin: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Container(
                                                                        height: 75,
                                                                        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                          ListTile(
                                                                              onTap: () {
                                                                                showDialog(context: context, builder: (BuildContext context) => storedForm(context: context, uuid: enumeratorLocal.uuid, speciesName: enumeratorLocal.speciesName, commonName: enumeratorLocal.commonName, speciesPic: enumeratorLocal.image, enumerator: enumeratorLocal.enumerator, date: enumeratorLocal.date, fishingGround: enumeratorLocal.fishingGround, landingCenter: enumeratorLocal.landingCenter, totalLandings: enumeratorLocal.totalLandings, boatName: enumeratorLocal.boatName, fishingGear: enumeratorLocal.fishingGear, fishingEffort: enumeratorLocal.fishingEffort, totalBoatCatch: enumeratorLocal.totalBoatCatch, sampleSerialNumber: enumeratorLocal.sampleSerialNumber, sampleWeight: enumeratorLocal.totalSampleWeight, weight: enumeratorLocal.weight, length: enumeratorLocal.length));
                                                                              },
                                                                              leading: Padding(
                                                                                padding: EdgeInsets.only(top: 8),
                                                                                child: Wrap(
                                                                                  children: [
                                                                                    Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          '${enumeratorLocal.commonName}',
                                                                                          style: TextStyle(
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontSize: 15,
                                                                                          ),
                                                                                        ),
                                                                                        Text("Haba: ${enumeratorLocal.length} cm Bigat: ${enumeratorLocal.weight} g"),
                                                                                        Text('${enumeratorLocal.landingCenter}')
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              trailing: Padding(padding: EdgeInsets.only(top: 20), child: Image.asset('${enumeratorLocal.image}', width: 60))),
                                                                        ])))));
                                                  }).toList(),
                                                )))),
                                  ),
                                ]));
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: (dateSelected.isBefore(dateNow) ||
                              dateSelected == dateNow)
                          ? MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/form_one',
                                    arguments: FormOneArguments(dateSelected));
                              },
                              elevation: 10,
                              color: Colors.green,
                              child: Icon(
                                Icons.add,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              shape: CircleBorder(),
                              minWidth: 50,
                            )
                          : SizedBox(height: 0),
                    ),
                  ],
                ),
              ])));
  showDialog(context: context, builder: (BuildContext context) => alert);
}
