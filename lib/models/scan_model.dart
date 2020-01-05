import 'package:componentes/providers/db_provider.dart';
import 'package:latlong/latlong.dart';

class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }) {
    if (this.valor.contains("http")) {
      this.tipo = "http";
    } else {
      this.tipo = "geo";
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
  LatLng getLatLng() {
    final latlog = this.valor.substring(4).split(",");
    return LatLng(double.parse(latlog[0]), double.parse(latlog[1]));
  }
}
