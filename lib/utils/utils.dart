import 'package:componentes/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

launchScan(BuildContext context, ScanModel scan) async {
  if (scan.tipo == "http") {
    String url = scan.valor;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    Navigator.pushNamed(context, 'qr/mapa', arguments: scan);
  }
}
