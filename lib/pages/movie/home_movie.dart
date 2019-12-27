import 'package:componentes/search/search_delegate.dart';
import 'package:componentes/widgets/card_swipe.dart';
import 'package:componentes/widgets/horizontal_movies.dart';
import 'package:flutter/material.dart';
import 'package:componentes/providers/peliculas_provider.dart';

class HomeMovie extends StatelessWidget {
  PeliculasProvider peliculasProvider = new PeliculasProvider();
  HomeMovie();
  @override
  Widget build(BuildContext context) {
    this.peliculasProvider.getPopulares();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: Text("App de películas"),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _swiperTarjetas(),
              _footer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    //final peliculas = peliculasProvider.getEnCine();
    return FutureBuilder(
      future: this.peliculasProvider.getEnCine(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            lista: snapshot.data,
          );
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Populares",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return HorizontalMovies(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Container(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
