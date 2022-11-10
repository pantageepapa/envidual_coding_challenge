import 'dart:math';

import 'package:envidual_coding_challenge/model/level.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LevelsDatabase {
  static final LevelsDatabase instance = LevelsDatabase._init();

  static Database? _database;

  LevelsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("database.db");

    await delete();
    for (var i = 0; i < 30; i++) {
      Level level = Level(level: Random().nextInt(24), time: i, id: i);
      await LevelsDatabase.instance.create(level);
    }

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final integerType = 'INTEGER NOT NULL';

    /*
    creating the table by specifying the type for each column, this function
    is only executed when the database doesnt exists
    */
    await db.execute('''CREATE TABLE $tableNotes(
      ${LevelFields.id} $idType,
      ${LevelFields.level} $integerType,
      ${LevelFields.time} $integerType
    )
''');
  }

  Future<void> delete() async {
    print("delete called");
    final db = await instance.database;
    await db.delete(tableNotes);
  }

  Future<Level> create(Level level) async {
    final db = await instance.database;
    //insertng the data into database by adding columns and corresponding values
    final id = await db.insert(tableNotes, level.toJson());
    //modifying the id
    print("successfully created");
    return level.copy(id: id);
  }

  Future<Level> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableNotes,
        columns: LevelFields.values,
        //prevents SQL injections
        where: '${LevelFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Level.fromJson(maps.first);
    } else {
      throw Exception("ID $id not found");
    }
  }

  Future<List<Level>> readAll() async {
    final db = await instance.database;
    final orderBy = "${LevelFields.time} ASC";
    final result = await db.query(tableNotes, orderBy: orderBy);
    print(result);
    return result.map((json) => Level.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  static Future<void> deleteDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    await databaseFactory.deleteDatabase(path);
  }
}
