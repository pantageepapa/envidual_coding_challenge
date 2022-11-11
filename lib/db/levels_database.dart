import 'dart:math';

import 'package:envidual_coding_challenge/model/level.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LevelsDatabase {
  //creates the instance of the database
  static final LevelsDatabase instance = LevelsDatabase._init();

  //private database variable
  static Database? _database;

  LevelsDatabase._init();

  //get method of the databse variable
  Future<Database> get database async {
    //checks if the database already exists
    if (_database != null) return _database!;

    //if not initialize the databse
    _database = await _initDB("database.db");

    //deletes the database, as the app starts from the beginning but the table could
    //still exist as its written in the document
    await delete();

    //adds 30 dummy data to the database
    for (var i = 0; i < 30; i++) {
      //adding id while creating the instance to be unique in the database
      Level level = Level(level: Random().nextInt(24), time: i, id: i);
      await LevelsDatabase.instance.create(level);
    }
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    //the path where the database is stored is being retrieved
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    //this creates the database
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    //this is the type of each column
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

    //deletes the table if it exists
    await db.delete(tableNotes);
  }

  Future<void> create(Level level) async {
    final db = await instance.database;
    //insertng the data into database by adding columns and corresponding values
    final id = await db.insert(tableNotes, level.toJson());
    //modifying the id
    print("successfully created");
  }

  Future<List<Level>> readAll() async {
    final db = await instance.database;
    //orders the result by the time
    final orderBy = "${LevelFields.time} ASC";
    final result = await db.query(tableNotes, orderBy: orderBy);
    //print(result);
    return result.map((json) => Level.fromJson(json)).toList();
  }

  // Future close() async {
  //   final db = await instance.database;
  //   db.close();
  // }

  // static Future<void> deleteDatabase(String filePath) async {
  //   final dbPath = await getDatabasesPath();
  //   final path = join(dbPath, filePath);
  //   await databaseFactory.deleteDatabase(path);
  // }
}
