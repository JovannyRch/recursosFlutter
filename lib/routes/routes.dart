import 'package:componentes/pages/crud/crud_home_page.dart';
import 'package:componentes/pages/crud/crud_login_page.dart';
import 'package:componentes/pages/design/design_home.dart';
import 'package:componentes/pages/movie/detalles_movie.dart';
import 'package:componentes/pages/movie/home_movie.dart';
import 'package:componentes/pages/preferencias_usuario/pu_home.dart';
import 'package:componentes/pages/preferencias_usuario/pu_settings.dart';
import 'package:componentes/pages/qr/qr_home_page.dart';
import 'package:componentes/pages/qr/qr_map.dart';
import 'package:flutter/material.dart';

import 'package:componentes/pages/alert_page.dart';
import 'package:componentes/pages/avatar_page.dart';
import 'package:componentes/pages/home.dart';
import 'package:componentes/pages/card_page.dart';
import 'package:componentes/pages/animated_container_page.dart';
import 'package:componentes/pages/slider_screen.dart';
import 'package:componentes/pages/mapa_page.dart';
import 'package:componentes/pages/gps_page.dart';
import 'package:componentes/pages/design/scroll_page.dart';

final rutas = <String, WidgetBuilder>{
  '/': (BuildContext context) => Home(),
  'alert': (BuildContext context) => AlertPage(),
  'avatar': (BuildContext context) => AvatarPage(),
  'card': (BuildContext context) => CardPage(),
  'contenedor': (BuildContext context) => AnimatedContainerPage(),
  'slider': (BuildContext context) => SliderPage(),
  'mapa': (BuildContext context) => MapaPage(),
  'gps': (BuildContext context) => GPSPage(),
  'movie/home': (BuildContext context) => HomeMovie(),
  'movie/detalles': (BuildContext context) => PeliculaDetalle(),
  'design/home': (BuildContext context) => DesignHome(),
  'desing/scroll': (BuildContext context) => ScrollPage(),
  'qr/home': (BuildContext context) => QRHome(),
  'qr/mapa': (BuildContext context) => QRMap(),
  'pu/home': (BuildContext context) => PUHome(),
  'pu/settings': (BuildContext context) => PUSettings(),
  'crud/login': (BuildContext context) => LoginCrudPage(),
  'crud/home': (BuildContext context) => HomeCrudPage(),
};
