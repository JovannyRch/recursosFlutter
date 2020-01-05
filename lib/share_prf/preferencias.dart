import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();
  bool _colorSecundario;
  int _genero;
  String _nombre;

  PreferenciasUsuario._internal();
  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get genero {
    return _prefs.getInt('genero') ?? 1;
  }

  set genero(int genero) {
    _prefs.setInt('genero', genero);
  }

  get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool colorSecundario) {
    _prefs.setBool('colorSecundario', colorSecundario);
  }

  get nombreUsuario {
    return _prefs.getString("nombreUsuario") ?? '';
  }

  set nombreUsuario(String nombre) {
    _prefs.setString('nombreUsuario', nombre);
  }

  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'pu/home';
  }

  set ultimaPagina(String nombre) {
    _prefs.setString('ultimaPagina', nombre);
  }

  factory PreferenciasUsuario() {
    return _instancia;
  }
}
