import 'dart:io';

import 'package:componentes/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

export 'package:componentes/models/scan_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._() {}

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'scans.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE scans"
        "(id INTEGER PRIMARY KEY,"
        "tipo text,"
        "valor text"
        ")",
      );
    });
  }

  newScan(ScanModel scan) async {
    final db = await database;
    return await db.insert('scans', scan.toJson());
  }

  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query('scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;
    final res = await db.query('scans');
    return res.isEmpty
        ? []
        : res.map((registro) => ScanModel.fromJson(registro)).toList();
  }

  Future<List<ScanModel>> getScansTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * from scans where tipo = '$tipo'");
    return res.isNotEmpty
        ? []
        : res.map((registro) => ScanModel.fromJson(registro)).toList();
  }

  Future<int> updateScan(ScanModel scan) async {
    final db = await database;
    final res = await db
        .update('scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete("DELETE from scans");
    return res;
  }
}
