import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smart_taal_system/backend/sqlfite_local_primary_db.dart';
import 'package:smart_taal_system/forms/input/arguments.dart';
import 'package:smart_taal_system/forms/output/stored_form.dart';
import 'package:smart_taal_system/widgets/buttons/add_button.dart';

import '../../widgets/buttons/submit_button.dart';
import '../../widgets/offline_cache_list.dart';

showStoredFormForDate(
    BuildContext context,
    Future<List<enumeratorLocal>> speciesName,
    String dateSelectedString,
    var firstName,
    var lastName) {
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

  var alert = SimpleDialog(
      contentPadding: EdgeInsets.all(10),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      children: [
        SingleChildScrollView(
          child: FutureBuilder<List<enumeratorLocal>>(
              future: speciesName,
              builder: (BuildContext context,
                  AsyncSnapshot<List<enumeratorLocal>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading...'));
                }
                if (dateSelected.isAfter(dateNow)) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Paalala',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800)),
                              FaIcon(FontAwesomeIcons.telegramPlane,
                                  color: Colors.black, size: 30)
                            ],
                          ),
                          Text(
                              "\nAng araw na ito (${dateSelectedString}) ay hindi pa nakalilipas. Makakapagtala ka lang ngayon o sa mga araw na nakalipas na."),
                        ],
                      ),
                    ),
                  );
                }
                return snapshot.data!.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Walang tala',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w800)),
                                      Text(
                                        "para sa araw ng: ${dateSelectedString}",
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.content_paste,
                                      color: Colors.black, size: 40)
                                ],
                              ),
                              Text(
                                  "\nPara magdagdag ng tala para sa araw na ito, mangyaring pindutin ang bilog na butones sa kanang ibaba."),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 20),
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Mga Talang Isda',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              Text(
                                                "para sa araw ng: ${dateSelectedString}",
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                          Center(
                                            child: FaIcon(FontAwesomeIcons.fish,
                                                color: Colors.black, size: 25),
                                          )
                                        ],
                                      ),
                                    )),
                                SizedBox(height: 10),
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
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: RefreshIndicator(
                                      onRefresh: () {
                                        return Future.delayed(
                                            Duration(seconds: 1), () {
                                          //setState(() {});
                                        });
                                      },
                                      child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(
                                              parent:
                                                  AlwaysScrollableScrollPhysics()),
                                          child: RawScrollbar(
                                            thumbColor: Colors.green,
                                            child: ListView(
                                              reverse: true,
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              children: snapshot.data!
                                                  .map((enumeratorLocal) {
                                                return Center(
                                                    child: Container(
                                                  height: 100,
                                                  child: Card(
                                                      elevation: 5,
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              5, 0, 10, 5),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      child: InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) => storedForm(
                                                                  context:
                                                                      context,
                                                                  uuid: enumeratorLocal
                                                                      .uuid,
                                                                  speciesName:
                                                                      enumeratorLocal
                                                                          .speciesName,
                                                                  commonName:
                                                                      enumeratorLocal
                                                                          .commonName,
                                                                  speciesPic:
                                                                      enumeratorLocal
                                                                          .image,
                                                                  enumerator:
                                                                      enumeratorLocal
                                                                          .enumerator,
                                                                  date: enumeratorLocal
                                                                      .date,
                                                                  fishingGround:
                                                                      enumeratorLocal
                                                                          .fishingGround,
                                                                  landingCenter:
                                                                      enumeratorLocal
                                                                          .landingCenter,
                                                                  totalLandings:
                                                                      enumeratorLocal
                                                                          .totalLandings,
                                                                  boatName: enumeratorLocal
                                                                      .boatName,
                                                                  fishingGear:
                                                                      enumeratorLocal
                                                                          .fishingGear,
                                                                  fishingEffort:
                                                                      enumeratorLocal
                                                                          .fishingEffort,
                                                                  totalBoatCatch:
                                                                      enumeratorLocal
                                                                          .totalBoatCatch,
                                                                  sampleSerialNumber:
                                                                      enumeratorLocal
                                                                          .sampleSerialNumber,
                                                                  sampleWeight:
                                                                      enumeratorLocal
                                                                          .totalSampleWeight,
                                                                  weight:
                                                                      enumeratorLocal
                                                                          .weight,
                                                                  length: enumeratorLocal
                                                                      .length));
                                                        },
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    10,
                                                                    5,
                                                                    10,
                                                                    10),
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  60,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 13,
                                                                    child: Wrap(
                                                                      children: [
                                                                        Text(
                                                                          '${enumeratorLocal.commonName}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w800,
                                                                            fontSize:
                                                                                13,
                                                                          ),
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text("${enumeratorLocal.length} cm | ${enumeratorLocal.weight} g",
                                                                                style: TextStyle(
                                                                                  fontSize: 13,
                                                                                )),
                                                                            Text('${enumeratorLocal.landingCenter}',
                                                                                style: TextStyle(
                                                                                  fontSize: 13,
                                                                                ))
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      flex: 4,
                                                                      child: Image.asset(
                                                                          '${enumeratorLocal.image}',
                                                                          width:
                                                                              80))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ));
                                              }).toList(),
                                            ),
                                          ))),
                                ),
                              ]),
                        ));
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            SizedBox(
              height: 50,
              child: (dateSelected.isBefore(dateNow) || dateSelected == dateNow)
                  //Null names
                  ? MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/form_one',
                            arguments: FormOneArguments(dateSelected, '', ''));
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
        )
      ]);
  showDialog(context: context, builder: (BuildContext context) => alert);
}
