import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<int> numeros = [1, 2, 3, 4, 5, 6, 7, 8];
  HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Componentes"),
      ),
      body: ListView(
        children: this._crearItems2(),
      ),
    );
  }

  List<Widget> _crearItems() {
    List<Widget> resultado = [];
    for (int n in this.numeros) {
      resultado
        ..add(ListTile(
          title: Text('' + n.toString()),
        ))
        ..add(Divider(
          thickness: 5.0,
        ));
    }
    return resultado;
  }

  List<Widget> _crearItems2() {
    return this
        .numeros
        .map((item) => Column(
              children: <Widget>[
                ListTile(
                  title: Text(item.toString() + ""),
                  subtitle: Text("Cualquier cosa"),
                  leading: Icon(Icons.access_alarm),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    print("Hola");
                  },
                ),
                Divider()
              ],
            ))
        .toList();
  }
}
