import 'package:componentes/models/pelicula_model.dart';
import 'package:componentes/providers/peliculas_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          print("cancelar");
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del navbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crear los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparacen cuando la persona escribe
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            future: PeliculasProvider().buscarPelicula(query),
            builder:
                (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              if (snapshot.hasData) {
                final peliculas = snapshot.data;
                return ListView(
                    children: peliculas
                        .map((pelicula) => ListTile(
                              leading: FadeInImage(
                                image: NetworkImage(pelicula.getPosterImg()),
                                placeholder:
                                    AssetImage('assets/img/no-image.jpg'),
                                width: 50.0,
                                fit: BoxFit.contain,
                              ),
                              title: Text(pelicula.title),
                              subtitle: Text(
                                pelicula.overview,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                close(context, null);
                                Navigator.pushNamed(context, 'movie/detalles',
                                    arguments: {
                                      'pelicula': pelicula,
                                      'isSwiper': false
                                    });
                              },
                            ))
                        .toList());
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
  }
}
