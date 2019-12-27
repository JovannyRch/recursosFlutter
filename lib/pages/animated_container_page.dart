import 'package:flutter/material.dart';
import 'dart:math' show Random;

class AnimatedContainerPage extends StatefulWidget {
  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  double _width = 40;
  double _height = 30;
  Color _color = Colors.red;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(30.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contenedor animado"),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: _color,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        backgroundColor: Colors.blue,
        onPressed: () {
          setState(() {
            _width = Random().nextInt(300).toDouble();
            _height = Random().nextInt(300).toDouble();
            _color = Color.fromRGBO(
              Random().nextInt(255),
              Random().nextInt(255),
              Random().nextInt(255),
              1,
            );
            _borderRadius =
                BorderRadius.circular(Random().nextInt(100).toDouble());
          });
        },
      ),
    );
  }
}
