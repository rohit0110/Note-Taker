import 'package:note_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
          id TEXT PRIMARY KEY,
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
  }

  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db!.query("notes");
    if (res.isEmpty) {
      return "";
    } else {
      var resultMap = res.toList();
      print(resultMap);
      return resultMap.isEmpty ? "" : resultMap;
    }
  }

  deleteNote(String id) async {
    final db = await database;
    await db!.rawDelete("DELETE FROM notes WHERE id = ?", [id]);
  }

  updateNotes(String id, String body, String title) async {
    final db = await database;
    await db!.rawUpdate(
        "UPDATE notes SET body = ?, title = ? WHERE id = ?", [body, title, id]);
  }
}
