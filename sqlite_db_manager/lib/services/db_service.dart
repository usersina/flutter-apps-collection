import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite_db_manager/models/classroom.dart';

class DbService {
  final int version = 1;
  Database? _database;

  static final DbService _dbServiceHelper = DbService._internal();
  DbService._internal();

  factory DbService() {
    return _dbServiceHelper;
  }

  Future<void> openDB() async {
    if (_database != null) return;
    _database ??= await openDatabase(
      p.join(await getDatabasesPath(), "my_database.db"),
      version: version,
      onCreate: (database, version) {
        database.execute("""
        CREATE TABLE classrooms(
          id INTEGER PRIMARY KEY,
          name TEXT
        );
        """);
        database.execute("""
        CREATE TABLE students(
          id INTEGER PRIMARY KEY,
          lastname TEXT,
          firstname TEXT,
          birth_date TEXT,
          classroom_id INTEGER,
          FOREIGN KEY(classroom_id) REFERENCES classrooms(id)
        );
        """);
      },
    );
  }

  Future<List<Classroom>> getClassrooms() async {
    await openDB();
    if (_database == null) {
      return Future.error("Cannot get classrooms list, database is null!");
    }
    final List<Map<String, dynamic>> rawResult =
        await _database!.query('classrooms');
    return List.generate(
      rawResult.length,
      (idx) => Classroom.fromMap(
        rawResult[idx],
      ),
    );
  }

  // ---- Testing function
  Future<void> testDB() async {
    await openDB();
    try {
      await _database?.execute("INSERT INTO classrooms VALUES(0, 'DSI-33');");
    } catch (e) {
      print("Cannot add the test classroom");
    }

    try {
      await _database?.execute(
          "INSERT INTO students VALUES(0, 'Doe', 'John', '15/04/1995', 0)");
    } catch (e) {
      print("Cannot insert the test student");
    }
    List? lists = await _database?.rawQuery("SELECT * FROM classrooms");
    List? items = await _database?.rawQuery("SELECT * FROM students");
    print(lists?[0]);
    print(items?[0]);
  }
}
