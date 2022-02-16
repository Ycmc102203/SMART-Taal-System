import 'package:flutter/material.dart';

showStoredForm(
    BuildContext context,
    String speciesName,
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
  String englishFilipinoName = '';

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
                      Text("${englishFilipinoName}"),
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
