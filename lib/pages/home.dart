import 'package:flutter/material.dart';
import 'package:componentes/providers/menu_provider.dart';
import 'package:componentes/pages/avatar_page.dart';
import 'package:componentes/pages/alert_page.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Componentes"),
        ),
        body: _lista(),
      ),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listItems(snapshot.data, context),
        );
      },
    );
  }
}

List<Widget> _listItems(List<dynamic> data, BuildContext context) {
  final iconosString = <String, IconData>{
    'add_alert': Icons.add_alert,
    'accessibility': Icons.accessibility,
    'folder_open': Icons.folder_open,
    'donut_large': Icons.donut_large,
    'all_inclusive': Icons.all_inclusive,
    'mapa': Icons.location_on,
    'movie': Icons.local_movies,
    'design': Icons.color_lens
  };
  return data
      .map((item) => ListTile(
            title: Text(item['texto']),
            leading: Icon(
              iconosString[item['icon']],
              color: Colors.blue,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
            ),
            onTap: () {
              /*  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AlertPage();
              })); */
              print(item['ruta']);
              Navigator.pushNamed(context, item['ruta']);
            },
          ))
      .toList();
}
