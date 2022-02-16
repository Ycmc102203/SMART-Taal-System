import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class enumeratorDays {
  final int? id;
  String date = 'date';
  String enumerator = 'enumerator';
  String landingCenter = 'landingCenter';
  String fishingGround = 'fishingGround';
  String totalLandings = 'totalLandings';

  enumeratorDays({
    this.id,
    required this.date,
    required this.enumerator,
    required this.landingCenter,
    required this.fishingGround,
    required this.totalLandings,
  });

  factory enumeratorDays.fromMap(Map<String, dynamic> json) =>
      new enumeratorDays(
        id: json['id'],
        date: json['date'],
        enumerator: json['enumerator'],
        landingCenter: json['landingCenter'],
        fishingGround: json['fishingGround'],
        totalLandings: json['totalLandings'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'enumerator': enumerator,
      'landingCenter': landingCenter,
      'fishingGround': fishingGround,
      'totalLandings': totalLandings,
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
    String path = p.join(databasesPath, 'enumeratorDaysData.db');

    //open/create database at a given path
    var enumeratorDatabase =
        await openDatabase(path, version: 5, onCreate: _onCreate);

    return enumeratorDatabase;

    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, 'enumeratorDaysData.db');
    // return await openDatabase(
    //   path,
    //   version: 5,
    //   onCreate: _onCreate,
    // );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE enumeratorDaysData(
          id INTEGER PRIMARY KEY,
          date TEXT,
          enumerator TEXT,
          landingCenter TEXT,
          fishingGround TEXT,
          totalLandings TEXT
      )
      ''');
  }

  Future<List<enumeratorDays>> getenumeratorDays() async {
    Database db = await instance.database;
    var enumeratorDaysData =
        await db.query('enumeratorDaysData', orderBy: 'date');
    List<enumeratorDays> enumeratorDaysList = enumeratorDaysData.isNotEmpty
        ? enumeratorDaysData.map((c) => enumeratorDays.fromMap(c)).toList()
        : [];
    return enumeratorDaysList;
  }

  Future<int> add(enumeratorDays enumeratorDays) async {
    Database db = await instance.database;
    return await db.insert('enumeratorDaysData', enumeratorDays.toMap());
  }
}
