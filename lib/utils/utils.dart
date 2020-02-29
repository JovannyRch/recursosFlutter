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

bool isNumber(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  if (n == null) return false;

  return true;
}

void mostrarAlerta(BuildContext context, String titulo, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
