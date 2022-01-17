import 'package:flutter_keep_google/data/model/note_model.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import 'dart:io';

class SqfliteInstance {
  SqfliteInstance._();
  static final SqfliteInstance instance = SqfliteInstance._();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();

    return _database!;
  }

  _initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = directory.path + 'db9.db';
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute(NoteModel.createTable());
    // await db.execute(MainMenuModel.insertData());
  }

  Future<int> create({Map<String, dynamic>? map, String? tableName}) async {
    Database db = await instance.database;
    return await db.insert(tableName!, map!);
  }

  Future<List<Map<String, dynamic>>> read({String? tableName}) async {
    Database db = await instance.database;

    return await db.query(tableName!);
  }

  Future<int> update({Map<String, dynamic>? map, String? tableName}) async {
    Database db = await instance.database;
    int id = map!['id'];
    return await db.update(tableName!, map, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete({int? id, String? tableName}) async {
    Database db = await instance.database;
    return await db.delete(tableName!, where: 'id = ?', whereArgs: [id]);
  }
}
