import 'package:componentes/share_prf/preferencias.dart';
import 'package:componentes/widgets/menu_side_widget.dart';
import 'package:flutter/material.dart';

class PUHome extends StatelessWidget {
  PreferenciasUsuario preferenciasUsuario = new PreferenciasUsuario();

  @override
  void initState() {
    this.preferenciasUsuario.ultimaPagina = "pu/home";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferencias de usuario"),
        backgroundColor: this.preferenciasUsuario.colorSecundario
            ? Colors.teal
            : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Color secundario: ${preferenciasUsuario.colorSecundario}"),
          Divider(),
          Text("Género: ${preferenciasUsuario.genero}"),
          Divider(),
          Text("Nombre de usuario: ${preferenciasUsuario.nombreUsuario}"),
          Divider(),
        ],
      ),
    );
  }
}
