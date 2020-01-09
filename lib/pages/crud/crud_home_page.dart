import 'package:flutter/material.dart';

class HomeCrudPage extends StatelessWidget {
  const HomeCrudPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Text("hola"),
      ),
    );
  }
}
