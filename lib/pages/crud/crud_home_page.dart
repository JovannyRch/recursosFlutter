import 'package:componentes/bloc/provider.dart';
import 'package:componentes/models/producto_model.dart';
import 'package:flutter/material.dart';

class HomeCrudPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productosBloc = Provider.productosBlock(context);
    productosBloc.cargarProducto();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.deepPurple,
      ),
      //body: _crearListado(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.pushNamed(context, 'crud/producto');
        },
      ),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: null,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) {
              return this.crearItem(context, productos[i]);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget crearItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      child: Column(
        children: <Widget>[
          (producto.fotoUrl == null)
              ? Image(
                  image: AssetImage('assets/img/no-image.jpg'),
                )
              : FadeInImage(
                  image: NetworkImage(producto.fotoUrl),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  height: 300.0,
                ),
          ListTile(
            title: Text('${producto.titulo} - ${producto.valor}'),
            subtitle: Text('${producto.id}'),
            onTap: () => Navigator.pushNamed(context, 'crud/producto',
                arguments: producto),
          ),
        ],
      ),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        /* this.productosProvider.borrarProducto(producto.id); */
      },
    );
  }
}
