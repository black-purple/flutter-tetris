import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await init();
      return _db;
    }
    return _db;
  }

  init() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "tetris.db");
    Database db = await openDatabase(path, onCreate: _onCreate, version: 1);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "scores" (
        "id" INTEGER NOT NULL PRIMARY KEY,
        "date" TEXT NOT NULL,
        "score" TEXT NOT NULL
      )
      ''');
  }

  getScores() async {
    var scoresDb = await db;
    var data = scoresDb!.rawQuery("SELECT * FROM scores");
    return data;
  }

  addScore(String scoreDate, String scoreValue) async {
    var scoresDb = await db;
    var data = scoresDb!.rawInsert(
        "INSERT INTO 'scores' ('date', 'score') VALUES ('$scoreDate', '$scoreValue')");
    return data;
  }

  deleteAll() async {
    var scoresDb = await db;
    var data = scoresDb!.rawQuery("DELETE * FROM scores");
    return data;
  }
}
