import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class enumeratorOffline {
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

  enumeratorOffline(
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

  factory enumeratorOffline.fromMap(Map<String, dynamic> json) =>
      new enumeratorOffline(
        id: json['idInt'],
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

class DatabaseHelperTwo {
  DatabaseHelperTwo._privateConstructor();
  static final DatabaseHelperTwo instance =
      DatabaseHelperTwo._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    //Get path of the directory for android and iOS.

    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'enumeratorOfflineData.db');

    //open/create database at a given path
    var enumeratorDatabase =
        await openDatabase(path, version: 6, onCreate: _onCreate);

    return enumeratorDatabase;

    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, 'enumeratorOfflineData.db');
    // return await openDatabase(
    //   path,
    //   version: 5,
    //   onCreate: _onCreate,
    // );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE enumeratorOfflineData(
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

  Future<List<enumeratorOffline>> getEnumeratorOffline() async {
    Database db = await instance.database;
    var enumeratorOfflineData =
        await db.query('enumeratorOfflineData', orderBy: 'date');
    List<enumeratorOffline> enumeratorOfflineList =
        enumeratorOfflineData.isNotEmpty
            ? enumeratorOfflineData
                .map((c) => enumeratorOffline.fromMap(c))
                .toList()
            : [];
    return enumeratorOfflineList;
  }

  Future<int> add(enumeratorOffline enumeratorOffline) async {
    Database db = await instance.database;
    return await db.insert('enumeratorOfflineData', enumeratorOffline.toMap());
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    int result = await db.delete("enumeratorOfflineData", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );
    return result;
  }
}
