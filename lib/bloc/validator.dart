import 'dart:async';

import 'package:componentes/models/scan_model.dart';

class Validator {
  final validarGeo =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final geoScans = scans.where((scan) => scan.tipo == "geo").toList();
    sink.add(geoScans);
  });

  final validarHttp =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final httpScans = scans.where((scan) => scan.tipo == "http").toList();
    sink.add(httpScans);
  });
}
