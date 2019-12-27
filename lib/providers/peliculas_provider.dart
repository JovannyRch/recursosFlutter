import 'dart:async';
import 'dart:convert';
import 'package:componentes/models/actores_model.dart';
import 'package:componentes/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  final _apiKey = "fbe69af876ef3161d3fa1768498a58a2";
  final _url = "api.themoviedb.org";
  final _languaege = "es-ES";
  int _popularesPage = 0;
  bool _cargando = false;

  //Bloc
  List<Pelicula> _populares = new List();
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();
  PeliculasProvider();

  void disposeStreams() {
    this._popularesStreamController?.close();
  }

  Function(List<Pelicula>) get popularesSink =>
      this._popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  Future<List<Pelicula>> getEnCine() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      "api_key": _apiKey,
      "language": _languaege,
    });

    final resp = await http.get(url);
    final dataDecode = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(dataDecode['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;

    this._popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      "api_key": _apiKey,
      "language": _languaege,
      'page': _popularesPage.toString()
    });

    final resp = await http.get(url);
    final dataDecode = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(dataDecode['results']);
    _populares.addAll(peliculas.items);
    popularesSink(_populares);
    _cargando = false;
    return peliculas.items;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    if (_cargando) return [];
    _cargando = true;

    this._popularesPage++;
    final url = Uri.https(_url, '3/search/movie',
        {"api_key": _apiKey, "language": _languaege, 'query': query});

    final resp = await http.get(url);
    final dataDecode = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(dataDecode['results']);
    return peliculas.items;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      "api_key": _apiKey,
      "language": _languaege,
    });

    final resp = await http.get(url);
    final dataDecoded = jsonDecode(resp.body);
    final cast = Cast.fromJsonList(dataDecoded['cast']);
    return cast.actores;
  }
}
