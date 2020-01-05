import 'dart:io';

import 'package:componentes/bloc/scan_blocs.dart';
import 'package:componentes/models/scan_model.dart';
import 'package:componentes/pages/qr/qr_direcciones.dart';
import 'package:componentes/pages/qr/qr_mapas.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:componentes/utils/utils.dart' as utils show launchScan;

class QRHome extends StatefulWidget {
  @override
  _QRHomeState createState() => _QRHomeState();
}

class _QRHomeState extends State<QRHome> {
  int _currentPage = 0;
  ScansBloc _scanBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              _scanBloc.deleteScans();
            },
          )
        ],
      ),
      body: Container(
        child: callPage(_currentPage),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scannQR(context),
      ),
    );
  }

  void _scannQR(BuildContext context) async {
    //https
    //geo:40.65133996321017,-74.27235975703127
    String futureString = "";
    //String futureString = "https//www.jovannyrch.com";
    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }

    if (futureString != null) {
      ScanModel scan = ScanModel(valor: futureString);
      final res = await _scanBloc.newScan(scan);

      if (Platform.isIOS) {
        Future.delayed(new Duration(milliseconds: 759), () {
          utils.launchScan(context, scan);
        });
      } else {
        utils.launchScan(context, scan);
      }
    }
  }

  Widget callPage(int indexPage) {
    if (indexPage == 0) return MapasPageQR();
    return DireccionesPage();
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      currentIndex: _currentPage,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text("Mapas"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text("Direcciones"),
        ),
      ],
    );
  }
}
