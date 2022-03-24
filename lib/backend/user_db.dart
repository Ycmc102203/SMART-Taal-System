import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class userData {
  final int? id;
  String firstName = 'firstName';
  String lastName = 'lastName';
  String nickname = 'nickname';
  String status = 'status';

  userData(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.nickname,
      required this.status});

  factory userData.fromMap(Map<String, dynamic> json) => new userData(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      nickname: json['nickname'],
      status: json['status']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'nickname': nickname,
      'status': status
    };
  }
}

class DatabaseHelperThree {
  DatabaseHelperThree._privateConstructor();
  static final DatabaseHelperThree instance =
      DatabaseHelperThree._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    //Get path of the directory for android and iOS.
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'userDataData.db');
    //open/create database at a given path
    var enumeratorDatabase =
        await openDatabase(path, version: 5, onCreate: _onCreate);
    return enumeratorDatabase;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE userDataData(
          id INTEGER PRIMARY KEY,
          firstName TEXT,
          lastName TEXT,
          nickname TEXT,
          status TEXT
      )
      ''');
  }

  Future<List<userData>> getEnumeratorLocal() async {
    Database db = await instance.database;
    var userDataData =
        await db.rawQuery('SELECT * FROM userDataData ORDER BY date');
    List<userData> userDataList = userDataData.isNotEmpty
        ? userDataData.map((c) => userData.fromMap(c)).toList()
        : [];
    return userDataList;
  }

  Future<List<userData>> getUser(id) async {
    Database db = await instance.database;
    var userDataData =
        await db.rawQuery('SELECT * FROM userDataData WHERE id = ?', ['${id}']);
    List<userData> userDataList = userDataData.isNotEmpty
        ? userDataData.map((c) => userData.fromMap(c)).toList()
        : [];
    return userDataList;
  }

  Future<int> add(userData userData) async {
    Database db = await instance.database;
    return await db.insert('userDataData', userData.toMap());
  }
}
