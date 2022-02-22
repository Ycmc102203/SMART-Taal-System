import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class enumeratorLocal {
  final int? id;
  String uuid = 'uuid';
  String date = 'date';
  String enumerator = 'enumerator';
  String landingCenter = 'landingCenter';
  String fishingGround = 'fishingGround';
  String totalLandings = 'totalLandings';
  String boatName = 'boatName';
  String fishingGear = 'fishingGear';
  String fishingEffort = 'fishingEffort';
  String totalBoatCatch = 'totalBoatCatch';
  String sampleSerialNumber = 'sampleSerialNumber';
  String totalSampleWeight = 'totalSampleWeight';
  String speciesName = 'speciesName';
  String commonName = 'commonName';
  String length = 'length';
  String weight = 'weight';
  String image = 'image';

  enumeratorLocal(
      {this.id,
      required this.uuid,
      required this.date,
      required this.enumerator,
      required this.landingCenter,
      required this.fishingGround,
      required this.totalLandings,
      required this.boatName,
      required this.fishingGear,
      required this.fishingEffort,
      required this.totalBoatCatch,
      required this.sampleSerialNumber,
      required this.totalSampleWeight,
      required this.speciesName,
      required this.commonName,
      required this.length,
      required this.weight,
      required this.image});

  factory enumeratorLocal.fromMap(Map<String, dynamic> json) =>
      new enumeratorLocal(
        id: json['id'],
        uuid: json['uuid'],
        date: json['date'],
        enumerator: json['enumerator'],
        landingCenter: json['landingCenter'],
        fishingGround: json['fishingGround'],
        totalLandings: json['totalLandings'],
        boatName: json['boatName'],
        fishingGear: json['fishingGear'],
        fishingEffort: json['fishingEffort'],
        totalBoatCatch: json['totalBoatCatch'],
        sampleSerialNumber: json['sampleSerialNumber'],
        totalSampleWeight: json['totalSampleWeight'],
        speciesName: json['speciesName'],
        commonName: json['commonName'],
        length: json['length'],
        weight: json['weight'],
        image: json['image'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'date': date,
      'enumerator': enumerator,
      'landingCenter': landingCenter,
      'fishingGround': fishingGround,
      'totalLandings': totalLandings,
      'boatName': boatName,
      'fishingGear': fishingGear,
      'fishingEffort': fishingEffort,
      'totalBoatCatch': totalBoatCatch,
      'sampleSerialNumber': sampleSerialNumber,
      'totalSampleWeight': totalSampleWeight,
      'speciesName': speciesName,
      'commonName': commonName,
      'length': length,
      'weight': weight,
      'image': image,
    };
  }
}

class DatabaseHelperOne {
  DatabaseHelperOne._privateConstructor();
  static final DatabaseHelperOne instance =
      DatabaseHelperOne._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    //Get path of the directory for android and iOS.

    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'enumeratorLocalData.db');

    //open/create database at a given path
    var enumeratorDatabase =
        await openDatabase(path, version: 5, onCreate: _onCreate);

    return enumeratorDatabase;

    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, 'enumeratorLocalData.db');
    // return await openDatabase(
    //   path,
    //   version: 5,
    //   onCreate: _onCreate,
    // );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE enumeratorLocalData(
          id INTEGER PRIMARY KEY,
          uuid TEXT,
          date TEXT,
          enumerator TEXT,
          landingCenter TEXT,
          fishingGround TEXT,
          totalLandings TEXT,
          boatName TEXT,
          fishingGear TEXT,
          fishingEffort TEXT,
          totalBoatCatch TEXT,
          sampleSerialNumber TEXT,
          totalSampleWeight TEXT,
          speciesName TEXT,
          commonName TEXT,
          length TEXT,
          weight TEXT,
          image TEXT
      )
      ''');
  }

  Future<List<enumeratorLocal>> getEnumeratorLocal() async {
    Database db = await instance.database;
    var enumeratorLocalData =
        await db.query('enumeratorLocalData', orderBy: 'date');
    List<enumeratorLocal> enumeratorLocalList = enumeratorLocalData.isNotEmpty
        ? enumeratorLocalData.map((c) => enumeratorLocal.fromMap(c)).toList()
        : [];
    return enumeratorLocalList;
  }

  Future<int> add(enumeratorLocal enumeratorLocal) async {
    Database db = await instance.database;
    return await db.insert('enumeratorLocalData', enumeratorLocal.toMap());
  }
}
