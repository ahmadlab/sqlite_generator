String databaseServiceTemplate = '''

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import './DatabaseModels.dart';

class DatabaseService {
  DatabaseService() : super();

  static final _databaseName = "DATABASE_NAME.db";
  static final _tableName = "avengers";


  static final _databaseVersion = 1;

  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    //--id INTEGER PRIMARY KEY AUTOINCREMENT,
    await db.execute("""
        CREATE TABLE avengers(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name text ,
          full_name text,
          gender text, 
          email text,
          is_can_swim int,
          is_can_fly int,
          status int,
          created_at text
        )
      """);

  }

  Future<List<TheAvengersModels>?> getAvengers() async {
    Database db = await database;
    var res = await db.query(_tableName, orderBy: 'id asc');
    List<TheAvengersModels> packageList =
        res.map((item) => TheAvengersModels.fromMap(item)).toList();
    return packageList;
  }

  Future<TheAvengersModels?> getSingleAvenger(int id) async {
    Database db = await database;
    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);
      return TheAvengersModels.fromMap(res.first);
  }

  Future<int> insertAvenger(TheAvengersModels model) async {
    Database db = await database;
    var res = await db.insert(_tableName, model.toMap());
    return res;
  }

  Future<int> updateAvenger(int id, TheAvengersModels model) async {
    Database db = await database;
    var res = await db.update(_tableName, model.toMap(), where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> deleteAvenger(int id, TheAvengersModels model) async {
    Database db = await database;
    var res = await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return res;
  }
}
''';