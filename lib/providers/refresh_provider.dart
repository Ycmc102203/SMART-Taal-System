import 'package:flutter/material.dart';

class ChangeCommonToSci extends ChangeNotifier {
  final commonNameController;
  String speciesNameController = '';
  String speciesPic = '';

  ChangeCommonToSci({required this.commonNameController});

  String get getSciName {
    return speciesNameController;
  }

  String get getSpeciesPic {
    return speciesPic;
  }

  void changeCommonToSciName(
      commonNameController, speciesNameController, speciesPic) {
    if (commonNameController == "Flag-tailed glass perchlet (ning-ning)") {
      speciesNameController = "Ambassis miops";
      speciesPic = 'assets/Ambassis miops.PNG';
      notifyListeners();
    } else if (commonNameController == "Midas cichlid (red tilapia)") {
      speciesNameController = "Amphilophus citrinellus";
      speciesPic = 'assets/Amphilophus citrinellus.PNG';
      notifyListeners();
    } else if (commonNameController == "Climbing perch (martiniko)") {
      speciesNameController = "Anabas testudineuseseseseses";
      speciesPic = 'assets/Anabas testudineus.PNG';
      notifyListeners();
    } else if (commonNameController == "Giant mottled eel (igat)") {
      speciesNameController = "Anguilla marmorata";
      speciesPic = 'assets/Anguilla marmorata.PNG';
      notifyListeners();
    } else if (commonNameController == "Manila sea catfish (kanduli)") {
      speciesNameController = "Arius manillensis";
      speciesPic = 'assets/Arius manillensis.PNG';
      notifyListeners();
    } else if (commonNameController == "Eendracht Land silverside (guno)") {
      speciesNameController = "Atherinomorus endrachtensis";
      speciesPic = 'assets/Atherinomorus endrachtensis.PNG';
      notifyListeners();
    } else if (commonNameController == "Giant trevally (maliputo)") {
      speciesNameController = "Caranx ignobilis";
      speciesPic = 'assets/Caranx ignobilis.PNG';
      notifyListeners();
    } else if (commonNameController == "Big-eye trevally (muslo)") {
      speciesNameController = "Caranx sexfasciatus";
      speciesPic = 'assets/Caranx sexfasciatus.PNG';
      notifyListeners();
    } else if (commonNameController == "Crucian carp (karpita)") {
      speciesNameController = "Carassius carassius";
      speciesPic = 'assets/Carassius carassius.PNG';
      notifyListeners();
    } else if (commonNameController == "Striped snakehead (dalag)") {
      speciesNameController = "Channa striata";
      speciesPic = 'assets/Channa striata.PNG';
      notifyListeners();
    } else if (commonNameController == "Milkfish (bangus)") {
      speciesNameController = "Chanos chanos";
      speciesPic = 'assets/Chanos chanos.PNG';
      notifyListeners();
    } else if (commonNameController == "Philippine catfish (hito)") {
      speciesNameController = "Clarias batrachus";
      speciesPic = 'assets/Clarias batrachus.PNG';
      notifyListeners();
    } else if (commonNameController == "Bighead catfish (hito)") {
      speciesNameController = "Clarias macrocephalus";
      speciesPic = 'assets/Clarias macrocephalus.PNG';
      notifyListeners();
    } else if (commonNameController == "Common carp (karpa)") {
      speciesNameController = "Cyprinus carpio";
      speciesPic = 'assets/Cyprinus carpio.PNG';
      notifyListeners();
    } else if (commonNameController == "Pipefish (kambabalo)") {
      speciesNameController = "Doryichthys martensii";
      speciesPic = 'assets/Doryichthys martensii.PNG';
      notifyListeners();
    } else if (commonNameController == "Tenpounder (Kanoping)") {
      speciesNameController = "Elops machnata";
      speciesPic = 'assets/Elops machnata.PNG';
      notifyListeners();
    } else if (commonNameController == "Half-barred cardinal (dangat)") {
      speciesNameController = "Fibramia thermalis";
      speciesPic = 'assets/Fibramia thermalis.PNG';
      notifyListeners();
    } else if (commonNameController == "Whipfin silver-biddy (balabatuhan)") {
      speciesNameController = "Gerres filamentosus";
      speciesPic = 'assets/Gerres filamentosus.PNG';
      notifyListeners();
    } else if (commonNameController == "Snakehead gudgeon (baculi)") {
      speciesNameController = "Giuris margaritacea";
      speciesPic = 'assets/Giuris margaritacea.PNG';
      notifyListeners();
    } else if (commonNameController == "Celebes goby (biyang bato)") {
      speciesNameController = "Glossogobius celebius";
      speciesPic = 'assets/Glossogobius celebius.PNG';
      notifyListeners();
    } else if (commonNameController == "Tank goby (biyang puti)") {
      speciesNameController = "Glossogobius giuris";
      speciesPic = 'assets/Glossogobius giuris.PNG';
      notifyListeners();
    } else if (commonNameController == "Bighead carp (bighead)") {
      speciesNameController = "Hypophthalmichthys nobilis";
      speciesPic = 'assets/Hypophthalmichthys nobilis.PNG';
      notifyListeners();
    } else if (commonNameController == "Quoy's garfish (siliw)") {
      speciesNameController = "Hyporhamphus quoyi";
      speciesPic = 'assets/Hyporhamphus quoyi.PNG';
      notifyListeners();
    } else if (commonNameController == "Barramundi (apahap)") {
      speciesNameController = "Lates calcarifer";
      speciesPic = 'assets/Lates calcarifer.PNG';
      notifyListeners();
    } else if (commonNameController == "Silver perch (ayungin)") {
      speciesNameController = "Leiopotherapon plumbeus";
      speciesPic = 'assets/Leiopotherapon plumbeus.PNG';
      notifyListeners();
    } else if (commonNameController == "Mangrove red snapper (also)") {
      speciesNameController = "Lutjanus argentimaculatus";
      speciesPic = 'assets/Lutjanus argentimaculatus.PNG';
      notifyListeners();
    } else if (commonNameController == "Malabar blood snapper (maya-maya)") {
      speciesNameController = "Lutjanus malabaricus";
      speciesPic = 'assets/Lutjanus malabaricus.PNG';
      notifyListeners();
    } else if (commonNameController == "Indo-Pacific tarpon (buan-buan)") {
      speciesNameController = "Megalops cyprinoides";
      speciesPic = 'assets/Megalops cyprinoides.PNG';
      notifyListeners();
    } else if (commonNameController == "Sharptail goby (biya)") {
      speciesNameController = "Oligolepis acutipennis";
      speciesPic = 'assets/Oligolepis acutipennis.PNG';
      notifyListeners();
    } else if (commonNameController == "Gossamer blenny (isdang mamay)") {
      speciesNameController = "Omobranchus ferox";
      speciesPic = 'assets/Omobranchus ferox.PNG';
      notifyListeners();
    } else if (commonNameController == "Nile tilapia (tilapia)") {
      speciesNameController = "Oreochromis niloticus";
      speciesPic = 'assets/Oreochromis niloticus.PNG';
      notifyListeners();
    } else if (commonNameController == "Striped catfish (pangasius)") {
      speciesNameController = "Pangasianodon hypophthalmus";
      speciesPic = 'assets/Pangasianodon hypophthalmus.PNG';
      notifyListeners();
    } else if (commonNameController == "Jaguar guapote (dugong)") {
      speciesNameController = "Parachromis managuensis";
      speciesPic = 'assets/Parachromis managuensis.PNG';
      notifyListeners();
    } else if (commonNameController == "Greenback mullet (Banak)") {
      speciesNameController = "Planiliza subviridis";
      speciesPic = 'assets/Planiliza subviridis.PNG';
      notifyListeners();
    } else if (commonNameController == "Sleepy goby (biya)") {
      speciesNameController = "Psammogobius biocellatus";
      speciesPic = 'assets/Psammogobius biocellatus.PNG';
      notifyListeners();
    } else if (commonNameController ==
        "Vermiculated sailfin catfish (janitor fish)") {
      speciesNameController = "Pterygoplichthys disjunctivus";
      speciesPic = 'assets/Pterygoplichthys disjunctivus.PNG';
      notifyListeners();
    } else if (commonNameController == "Freshwater sardine (tawilis)") {
      speciesNameController = "Sardinella tawilis";
      speciesPic = 'assets/Sardinella tawilis.PNG';
      notifyListeners();
    } else if (commonNameController == "Blackchin tilapia (tilapiang arroyo)") {
      speciesNameController = "Sarotherodon melanotheron";
      speciesPic = 'assets/Sarotherodon melanotheron.PNG';
      notifyListeners();
    } else if (commonNameController == "Spotted scat (kitang)") {
      speciesNameController = "Scatophagus argus";
      speciesPic = 'assets/Scatophagus argus.PNG';
      notifyListeners();
    } else if (commonNameController == "Jarbua terapon (bagaong)") {
      speciesNameController = "Terapon jarbua";
      speciesPic = 'assets/Terapon jarbua.PNG';
      notifyListeners();
    } else if (commonNameController == "Banded archerfish (kataba)") {
      speciesNameController = "Toxotes jaculatrix";
      speciesPic = 'assets/Toxotes jaculatrix.PNG';
      notifyListeners();
    } else if (commonNameController == "Three spot gourami (gurami)") {
      speciesNameController = "Trichopodus trichopterus";
      speciesPic = 'assets/Trichopodus trichopterus.PNG';
      notifyListeners();
    } else if (commonNameController == "Humpbacked cardinalfish (muang)") {
      speciesNameController = "Yarica hyalosoma";
      speciesPic = 'assets/Yarica hyalosoma.PNG';
      notifyListeners();
    } else if (commonNameController == "Feathered river-garfish (siliw)") {
      speciesNameController = "Zenarchopterus dispar";
      speciesPic = 'assets/Zenarchopterus dispar.PNG';
      notifyListeners();
    }
  }
}
