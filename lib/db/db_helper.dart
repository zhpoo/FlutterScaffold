import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _dbName = 'main.db';
const _version = 1;

class DbHelper {
  const DbHelper._();

  static DbHelper _instance;

  factory DbHelper() {
    _instance ??= const DbHelper._();
    return _instance;
  }

  static const columnId = 'id';
  static const table = 'table';
  static const columnIndex = 'index';

  static Database _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    }
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);

    _db = await openDatabase(path, version: _version, onUpgrade: _onUpgrade);
    return _db;
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < 1) {
      // create db.
      db.execute(
        'CREATE TABLE $table ('
        '$columnId INTEGER PRIMARY KEY, '
        '$columnIndex INTEGER'
        ')',
      );
    }
  }
}
