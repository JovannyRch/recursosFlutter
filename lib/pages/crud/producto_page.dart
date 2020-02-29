import 'dart:io';

import 'package:componentes/models/producto_model.dart';
import 'package:componentes/providers/productos_provider.dart';
import 'package:flutter/material.dart';
import 'package:componentes/utils/utils.dart' as utils show isNumber;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffolKey = GlobalKey<ScaffoldState>();
  bool isGuardando = false;
  File foto;
  ProductoModel producto = new ProductoModel();
  ProductosProvider productosProvider = new ProductosProvider();
  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      this.producto = prodData;
    }
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Producto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _mostrarFoto(),
                _crearPrecio(),
                _creaerDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mostrarFoto() {
    if (this.producto.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        fit: BoxFit.contain,
        height: 300.0,
      );
    } else {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/img/no-image.jpg'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _seleccionarFoto() async {
    this.procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    this.procesarImagen(ImageSource.camera);
  }

  void procesarImagen(ImageSource source) async {
    this.foto = await ImagePicker.pickImage(
      source: source,
    );
    if (this.foto != null) {
      this.producto.fotoUrl = null;
    }
    setState(() {});
  }

  Widget _creaerDisponible() {
    return SwitchListTile(
        value: this.producto.disponible,
        title: Text("Disponible"),
        onChanged: (valor) {
          setState(() {
            this.producto.disponible = valor;
          });
        },
        activeColor: Colors.deepPurple);
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      icon: Icon(Icons.save),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text("Guardar"),
      onPressed: isGuardando ? null : _submit,
    );
  }

  _submit() async {
    setState(() {
      this.isGuardando = true;
    });

    if (this.foto != null) {
      this.producto.fotoUrl = await productosProvider.subirImagen(foto);
    }

    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();
    //Cuando el formularo es valido
    if (producto.id == null) {
      this.productosProvider.crearProducto(producto);
    } else {
      this.productosProvider.editarProducto(producto);
    }
    this._mostrarMensaje('Registro guardado');
    /* this.isGuardando = false; */
    Navigator.pop(context);
    setState(() {});
  }

  void _mostrarMensaje(String mensaje) {
    final snackBar = new SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffolKey.currentState.showSnackBar(snackBar);
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: this.producto.titulo,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      textCapitalization: TextCapitalization.sentences,
      onSaved: (valor) {
        this.producto.titulo = valor;
      },
      validator: (valor) {
        if (valor.length < 3) return 'Ingrese el nombre del producto';
        return null;
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: this.producto.valor.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (valor) {
        this.producto.valor = double.parse(valor);
      },
      validator: (valor) {
        if (utils.isNumber(valor)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }
}
