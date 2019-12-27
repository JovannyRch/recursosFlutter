import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valor = 200;
  bool _isEnable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider Page"),
      ),
      body: Column(
        children: <Widget>[
          _crearSlider(),
          _crearCheckbox(),
          _crearSwitch(),
          Expanded(
            child: FadeInImage(
              image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/3/37/Catedral_Toluca.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fit: BoxFit.contain,
              width: _valor,
            ),
          )
        ],
      ),
    );
  }

  Widget _crearCheckbox() {
    return CheckboxListTile(
      title: Text("Editar"),
      value: _isEnable,
      onChanged: (value) {
        setState(() {
          setState(() {
            _isEnable = value;
          });
        });
      },
    );
  }

  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text("Editar"),
      value: _isEnable,
      onChanged: (value) {
        setState(() {
          _isEnable = value;
        });
      },
    );
  }

  Widget _crearSlider() {
    return Slider(
      min: 0,
      max: 500,
      value: _valor,
      onChanged: !_isEnable
          ? null
          : (value) {
              setState(() {
                _valor = value;
              });
            },
    );
  }
}
