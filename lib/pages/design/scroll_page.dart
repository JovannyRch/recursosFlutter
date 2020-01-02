import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _pagina1(),
          _pagina2(),
        ],
      ),
    );
  }

  Widget _pagina1() {
    return Stack(
      children: <Widget>[
        _colorFondo(),
        _imagenFondo(),
        _texto(),
      ],
    );
  }

  Widget _texto() {
    final textStyle = TextStyle(fontSize: 50.0, color: Colors.white);
    return SafeArea(
      child: Column(
        children: <Widget>[
          Text(
            "10°",
            style: textStyle,
          ),
          Text(
            "Domingo",
            style: textStyle,
          ),
          Expanded(
            child: Container(),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 70.0,
          )
        ],
      ),
    );
  }

  Widget _imagenFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/img/scroll-1.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _colorFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(112, 192, 218, 1.0),
    );
  }

  Widget _pagina2() {
    return Container(
      child: Center(
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.blue,
          shape: StadiumBorder(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Text(
              "Bienvenidos",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          onPressed: () {},
        ),
      ),
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(112, 192, 218, 1.0),
    );
  }
}
