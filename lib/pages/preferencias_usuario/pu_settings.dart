import 'package:componentes/share_prf/preferencias.dart';
import 'package:componentes/widgets/menu_side_widget.dart';
import 'package:flutter/material.dart';

class PUSettings extends StatefulWidget {
  @override
  _PUSettingsState createState() => _PUSettingsState();
}

class _PUSettingsState extends State<PUSettings> {
  bool _colorSecundario = true;
  int _genero = 1;
  String _nombre = "Jovanny";
  TextEditingController _textEditingController;
  PreferenciasUsuario preferenciasUsuario = new PreferenciasUsuario();

  @override
  void initState() {
    this.preferenciasUsuario.ultimaPagina = "pu/settings";
    super.initState();
    this._textEditingController = new TextEditingController(
      text: this.preferenciasUsuario.nombreUsuario,
    );
    this._genero = this.preferenciasUsuario.genero;
    this._colorSecundario = this.preferenciasUsuario.colorSecundario;
  }

  _setSelectRadio(int value) async {
    preferenciasUsuario.genero = value;
    setState(() {
      _genero = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Ajustes"),
          backgroundColor: this.preferenciasUsuario.colorSecundario
              ? Colors.teal
              : Colors.blue),
      drawer: MenuWidget(),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Text(
            "Settings",
            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          ),
          Divider(),
          SwitchListTile(
            value: _colorSecundario,
            title: Text("Color secundario"),
            onChanged: (value) {
              setState(() {
                _colorSecundario = value;
                this.preferenciasUsuario.colorSecundario = value;
              });
            },
          ),
          RadioListTile(
            value: 1,
            groupValue: _genero,
            title: Text("Masculino"),
            onChanged: _setSelectRadio,
          ),
          RadioListTile(
            value: 2,
            groupValue: _genero,
            title: Text("Femenino"),
            onChanged: _setSelectRadio,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Nombre de la persona dueña del telefono',
              ),
              onChanged: (value) {
                _nombre = value;
                this.preferenciasUsuario.nombreUsuario = value;
              },
            ),
          )
        ],
      ),
    );
  }
}
