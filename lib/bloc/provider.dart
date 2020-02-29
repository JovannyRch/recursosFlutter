import 'package:componentes/bloc/login_bloc.dart';
import 'package:componentes/bloc/productos_bloc.dart';
export 'package:componentes/bloc/productos_bloc.dart';
export 'package:componentes/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final loginBloc = new LoginBloc();
  final _productosBloc = new ProductosBloc();
  static Provider instancia;

  factory Provider({Key key, Widget child}) {
    if (instancia == null) {
      instancia = new Provider._internal(key: key, child: child);
    }
    return instancia;
  }
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductosBloc productosBlock(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        ._productosBloc;
  }
}
