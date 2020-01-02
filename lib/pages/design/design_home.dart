import 'package:flutter/material.dart';

class DesignHome extends StatelessWidget {
  final titulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final subtitulo = TextStyle(fontSize: 18.0, color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage(
                  "https://images.pexels.com/photos/814499/pexels-photo-814499.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Lago con muchos árboles aquí",
                          style: titulo,
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Text(
                          "Una lago en Alemania",
                          style: subtitulo,
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  Text(
                    "41",
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                crearLogo(Icons.phone, "Llamar"),
                crearLogo(Icons.near_me, "Ruta"),
                crearLogo(Icons.share, "Compartir"),
              ],
            ),
            crearText(
              "Et amet commodo proident pariatur occaecat consectetur velit fugiat occaecat qui. Proident sit cupidatat non exercitation incididunt qui pariatur. Adipisicing ut irure aute qui nisi cupidatat enim reprehenderit minim fugiat labore Lorem mollit. Consequat occaecat occaecat commodo labore cupidatat occaecat. Deserunt cupidatat eu amet esse dolore tempor mollit laborum nostrud adipisicing labore cupidatat.",
            ),
            crearText(
              "Et amet commodo proident pariatur occaecat consectetur velit fugiat occaecat qui. Proident sit cupidatat non exercitation incididunt qui pariatur. Adipisicing ut irure aute qui nisi cupidatat enim reprehenderit minim fugiat labore Lorem mollit. Consequat occaecat occaecat commodo labore cupidatat occaecat. Deserunt cupidatat eu amet esse dolore tempor mollit laborum nostrud adipisicing labore cupidatat.",
            ),
            crearText(
              "Et amet commodo proident pariatur occaecat consectetur velit fugiat occaecat qui. Proident sit cupidatat non exercitation incididunt qui pariatur. Adipisicing ut irure aute qui nisi cupidatat enim reprehenderit minim fugiat labore Lorem mollit. Consequat occaecat occaecat commodo labore cupidatat occaecat. Deserunt cupidatat eu amet esse dolore tempor mollit laborum nostrud adipisicing labore cupidatat.",
            )
          ],
        ),
      ),
    );
  }

  Container crearText(String texto) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      child: Text(
        texto,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget crearLogo(IconData icon, String texto) {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.blueAccent,
            size: 40.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            texto,
            style: TextStyle(color: Colors.blueAccent, fontSize: 15.0),
          )
        ],
      ),
    );
  }
}
