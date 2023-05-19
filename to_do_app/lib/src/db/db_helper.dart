import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/src/models/task.dart';

class DbHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'tasks';

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print('Criando um novo');
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title STRING, note TEXT, date STRING, "
          "startTime STRING, endTime STRING, "
          "remind INTEGER, repeat STRING, "
          "color INTEGER, "
          "isCompleted INTEGER)",
        );
      });
    } catch (e, s) {
      log('Erro ao iniciar o db', error: e, stackTrace: s);
    }
  }

  static Future<int> insert(Task? task) async {
    print('Função de inserir');
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }
}
