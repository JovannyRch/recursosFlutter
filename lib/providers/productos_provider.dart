import 'dart:convert';

import 'package:componentes/models/producto_model.dart';
import 'package:componentes/share_prf/preferencias.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class ProductosProvider {
  final String _url = 'https://flutter-chat-e1a40.firebaseio.com/';
  final prefs = new PreferenciasUsuario();
  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json?auth=${prefs.token}';
    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json?auth=${prefs.token}';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    if (decodedData == null) return [];
    if (decodedData['error'] != null) return [];
    final List<ProductoModel> productos = [];
    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
    });
    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json?auth=${prefs.token}';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json?auth=${prefs.token}';
    final resp = await http.put(url, body: producto);
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<String> subirImagen(File imagen) async {
    //ri0byjug
    final url = Uri.parse('');
    final mimeType = mime(imagen.path).split('/');

    final uploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );
    uploadRequest.files.add(file);
    final streamResponse = await uploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print("algo salió mal");
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}
