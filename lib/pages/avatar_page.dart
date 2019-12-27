import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Avatar page"),
          actions: <Widget>[
            CircleAvatar(
              child: Text("j19"),
              backgroundColor: Colors.brown,
            )
          ],
        ),
        body: Center(
          child: Text("hola"),
        ),
      ),
    );
  }
}
