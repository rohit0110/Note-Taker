import 'package:flutter/cupertino.dart';
import 'package:note_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
        onCreate: ((db, version) async {
      await db.execute(''' 
        CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          body TEXT,
          creationDate DATE
        )
        ''');
    }), version: 1);
  }

  addNewNote(NoteModel note) async {
    final db = await database;
    db!.insert("notes", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("inserts");
  }

  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db!.query("notes");
    if (res.isEmpty) {
      // print(res);
      return "";
    } else {
      var resultMap = res.toList();
      print(resultMap);
      return resultMap.isEmpty ? "" : resultMap;
    }
  }
}
