import 'package:uuid/uuid.dart';

class EnumeratorRawDataColumn {
  static final String uuid = 'uuid';
  static final String date = 'date';
  static final String enumerator = 'enumerator';
  static final String landingCenter = 'landingCenter';
  static final String fishingGround = 'fishingGround';
  static final String totalLandings = 'totalLandings';
  static final String boatName = 'boatName';
  static final String fishingGear = 'fishingGear';
  static final String fishingEffort = 'fishingEffort';
  static final String totalBoatCatch = 'totalBoatCatch';
  static final String sampleSerialNumber = 'sampleSerialNumber';
  static final String totalSampleWeight = 'totalSampleWeight';
  static final String speciesName = 'speciesName';
  static final String commonName = 'speciesName';
  static final String length = 'length';
  static final String weight = 'weight';

  static List getColumns() => [
        uuid,
        date,
        enumerator,
        landingCenter,
        fishingGround,
        totalLandings,
        boatName,
        fishingGear,
        fishingEffort,
        totalBoatCatch,
        sampleSerialNumber,
        totalSampleWeight,
        speciesName,
        commonName,
        length,
        weight
      ];
}
