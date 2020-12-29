import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'course.dart';
import 'package:new_edutarget/constants/const.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();

  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async {
    return _database ?? await initDb();
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "CourseDb.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE Course ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "imageName TEXT,"
          "authorName TEXT,"
          "color TEXT"
          ")",
        );
        await db.execute(
          "INSERT INTO Course('id', 'name', 'imageName', 'authorName', 'color') values (?, ?, ?, ?, ?,)",
          [
            1,
            "Fundamentals of Mathematics",
            "assets/svg/Maths-alt.svg",
            "Damilola Oregunwa",
            "red"
          ],
        );
      },
    );
  }

  Future<List<Map>> search(String query, SearchType type) async {
    final db = await database;
    String stringType;
    switch (type) {
      case SearchType.name:
        stringType = "name";
        break;
      case SearchType.author:
        stringType = "authorName";
        break;
      default:
        stringType = "name";
    }
    var map =
        db.rawQuery("SELECT * FROM Course WHERE $stringType like '%$query%'");
    return map;
  }
}
