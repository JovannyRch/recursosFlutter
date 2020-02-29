import 'dart:io';

import 'package:componentes/models/producto_model.dart';
import 'package:componentes/providers/productos_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProductosBloc {
  final _productosController = BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = BehaviorSubject<bool>();

  final productosProvider = new ProductosProvider();

  Stream<List<ProductoModel>> get producotosStream =>
      _productosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  dispose() {
    _productosController?.close();
    _cargandoController?.close();
  }

  void cargarProducto() async {
    final productos = await this.productosProvider.cargarProductos();
    this._productosController.sink.add(productos);
  }

  void agregarProducto(ProductoModel producto) async {
    this._cargandoController.sink.add(true);
    await this.productosProvider.crearProducto(producto);
    this._cargandoController.sink.add(false);
  }

  Future<String> subirFoto(File foto) async {
    this._cargandoController.sink.add(true);
    final fotoUrl = await this.productosProvider.subirImagen(foto);
    this._cargandoController.sink.add(false);
    return fotoUrl;
  }

  void editarProducto(ProductoModel producto) async {
    this._cargandoController.sink.add(true);
    await this.productosProvider.editarProducto(producto);
    this._cargandoController.sink.add(false);
  }

  void eliminarProducto(String id) async {
    this._cargandoController.sink.add(true);
    await this.productosProvider.borrarProducto(id);
    this._cargandoController.sink.add(false);
  }
}
