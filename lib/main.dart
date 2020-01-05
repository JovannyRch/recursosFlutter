import 'package:componentes/share_prf/preferencias.dart';
import 'package:flutter/material.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenciasUsuario preferenciasUsuario = new PreferenciasUsuario();
  await preferenciasUsuario.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Componentes',
      initialRoute: '/',
      routes: rutas,
    );
  }
}
