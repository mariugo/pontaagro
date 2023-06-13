import 'package:path/path.dart';
import 'package:pontaagro/core/data/database/sql_script.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _dbsqlite = DbHelper._internal();
  Database? _db;

  factory DbHelper() {
    return _dbsqlite;
  }

  DbHelper._internal() {
    db;
  }

  Future<Database> get db async {
    _db ??= await _initializeDatabase();
    return _db!;
  }

  Future<Database> _initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'pontaagro.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(farmTableScript);
        await db.execute(animalTableScript);
      },
    );
  }
}
