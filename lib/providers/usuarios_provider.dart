import 'dart:convert';

import 'package:componentes/share_prf/preferencias.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final apiKey = "AIzaSyAx_yMUE2rmrhIUvojENXmGJtWFAkGLE5o";
  final _prefs = new PreferenciasUsuario();
  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final auth = {
      'email': email,
      'password': password,
      'returnSecuredToken': true,
    };
    final resp = await http.post(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey",
        body: json.encode(auth));
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    }
    return {'ok': false, 'menseje': decodedResp['error']['message']};
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final auth = {
      'email': email,
      'password': password,
      'returnSecuredToken': true,
    };
    final resp = await http.post(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey",
        body: json.encode(auth));
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    }
    return {'ok': false, 'menseje': decodedResp['error']['message']};
  }
}
