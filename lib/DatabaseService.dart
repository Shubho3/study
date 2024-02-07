// database_service.dart
import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:study/MasterData.dart';

class DatabaseService {
  static Database? _database;
  static const String tableName = 'master_data';
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }
  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database_name.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY,
            name TEXT
          )
        ''');
      },
    );
  }
  static Future<List<MasterData>> getMasterData() async {
    final Database db = await database;

    // Fetch all rows from the SQLite database
    List<Map<String, dynamic>> result = await db.query(tableName);

    // Convert the result to a list of MasterData objects
    List<MasterData> masterDataList = result.map((data) {
      return MasterData(
        id: data['id'],
        name: data['name'],
      );
    }).toList();

    return masterDataList;
  }

  static Future<void> saveMasterData(List<MasterData> masterDataList)
  async {
    final Database db = await database;
    masterDataList.forEach((data) async {
      log('forEachDATA${data.toString()}');
      await db.insert(
        tableName,
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }
  static Future<void> deleteMasterData(int id) async {
    final Database db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> saveMasterDataSingle(String name) async {
    final Database db = await database;
    Map<String, dynamic> data = {'name': name};

    // Insert the data into the SQLite database
    int id = await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  static Future<void> updateMasterData(int id, String newName) async {
    final Database db = await database;
    Map<String, dynamic> data = {'name': newName};

    // Update the data in the SQLite database
    await db.update(
      tableName,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
