import 'dart:async';

import 'package:componentes/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc() => _singleton;

  ScansBloc._internal() {
    //Obtener los Scans de la base de datos
    getScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  getScans() async {
    _scansController.sink.add(await DBProvider.db.getScans());
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteScans() async {
    await DBProvider.db.deleteAll();
    getScans();
  }

  newScan(ScanModel scan) async {
    await DBProvider.db.newScan(scan);
    getScans();
  }
}
