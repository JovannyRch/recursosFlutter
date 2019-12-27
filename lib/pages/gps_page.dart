import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GPSPage extends StatefulWidget {
  @override
  _GPSPageState createState() => _GPSPageState();
}

class _GPSPageState extends State<GPSPage> {
  String ubicacion = "Sin asignar";
  String latitude = "";
  String altitud = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(altitud, style: TextStyle(
                fontSize: 30.0
            ),),
            Text(latitude, style: TextStyle(
                fontSize: 30.0
            ),),
            FlatButton(
              child: Text("Obtener ubicación", style: TextStyle(
                color: Colors.white,

              ),textAlign: TextAlign.center,),
              onPressed: (){
                this.setUbicacion();
              },
              color: Colors.lightBlue,
            )
          ],
        ),
      ),
    );
  }

  void setUbicacion() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = "Latitude: ${position.latitude}";
      altitud = "Longitud: ${position.longitude}";
    });
  }
}
