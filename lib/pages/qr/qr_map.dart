import 'package:componentes/models/scan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class QRMap extends StatefulWidget {
  @override
  _QRMapState createState() => _QRMapState();
}

class _QRMapState extends State<QRMap> {
  MapController mapCrtrl = new MapController();

  String tipoMapa = "streets";
  int indexMap = 0;
  final List<String> tipos = [
    "streets",
    "dark",
    "light",
    "outdoors",
    "satellite"
  ];
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Coordenadas QR"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapCrtrl.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: Center(
        child: _crearMapa(scan),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          this.tipoMapa = this.tipos[this.indexMap];
          this.indexMap++;
          if (this.indexMap == this.tipos.length) this.indexMap = 0;
          setState(() {});
        },
      ),
    );
  }

  Widget _crearMapa(ScanModel scanModel) {
    return FlutterMap(
      mapController: mapCrtrl,
      options: new MapOptions(
        center: scanModel.getLatLng(),
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1Ijoiam92YW5ueXJjaCIsImEiOiJjazRmdWJqYjQwamZ1M2xwMjE0ZWVlZGxiIn0.Go6ff35VFrdev8hmTFK5Ow',
            'id': 'mapbox.$tipoMapa',
          },
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: scanModel.getLatLng(),
              builder: (ctx) => new Container(
                child: Icon(
                  Icons.location_on,
                  size: 70,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
