import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import "package:notes_app/model/notes_model.dart";

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'abc.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE ncb("
        "id TEXT PRIMARY KEY, "
        "title TEXT NOT NULL, "
        "desc TEXT NOT NULL"
        ");");
  }

  Future<NotesModel> insert(NotesModel note) async {
    var dbClient = await db;
    await dbClient!.insert(
      'ncb',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return note;
  }

  Future<List<NotesModel>> getNotesList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('ncb');

    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  Future<int> delete(String id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'ncb',
      where: 'id= ?',
      whereArgs: [id],
    );
  }

  Future<int> update(NotesModel note) async {
    var dbClient = await db;
    return await dbClient!.update(
      'ncb',
      {
        "title": note.title,
        "desc": note.desc,
      },
      where: 'id= ?',
      whereArgs: [note.id],
    );
  }
}
