import 'package:componentes/bloc/provider.dart';
import 'package:componentes/providers/usuarios_provider.dart';
import 'package:flutter/material.dart';
import 'package:componentes/utils/utils.dart' as utils;

class RegistroCrudPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(
              vertical: 50.0,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0,
                  )
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  "Ingresa",
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(context, bloc),
              ],
            ),
          ),
          FlatButton(
            child: Text("Crear cuenta"),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'crud/login'),
          ),
        ],
      ),
    );
  }

  Widget _crearBoton(BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          onPressed: !snapshot.hasData ? null : () => _registro(context, bloc),
          child: Container(
            child: Text("Registrarse"),
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 5.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
        );
      },
    );
  }

  void _registro(BuildContext context, LoginBloc bloc) async {
    /* Navigator.pushReplacementNamed(context, 'crud/home'); */
    var resp =
        await this.usuarioProvider.nuevoUsuario(bloc.email, bloc.password);
    if (resp['ok'])
      Navigator.pushReplacementNamed(context, 'crud/home');
    else {
      utils.mostrarAlerta(context, 'Aviso', 'Las credenciales no son válidas');
    }
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.purple,
              ),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                color: Colors.purple,
              ),
              labelText: 'Contraseña',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0),
      ])),
    );
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    final iconoText = Container(
      padding: EdgeInsets.only(top: 40.0),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.person_pin_circle,
            size: 100,
            color: Colors.white,
          ),
          SizedBox(
            height: 10.0,
            width: double.infinity,
          ),
          Text(
            "Jovasoft",
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          )
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(child: circulo, top: 90.0, left: 30.0),
        Positioned(child: circulo, top: -40.0, right: -30.0),
        Positioned(child: circulo, bottom: -50.0, right: -10.0),
        Positioned(child: circulo, bottom: 120.0, right: 20.0),
        Positioned(child: circulo, bottom: -50.0, left: -20.0),
        iconoText,
      ],
    );
  }
}
