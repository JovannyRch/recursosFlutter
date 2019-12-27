import 'package:componentes/models/actores_model.dart';
import 'package:componentes/models/pelicula_model.dart';
import 'package:componentes/providers/peliculas_provider.dart';
import 'package:flutter/material.dart';

class PeliculaDetalle extends StatelessWidget {
  PeliculaDetalle();
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    final Pelicula pelicula = data['pelicula'];
    final bool isSwiper = data['isSwiper'] ? true : false;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _appBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              peliculaPoster(context, pelicula, isSwiper),
              _descripcion(pelicula),
              _crearCasting(pelicula),
            ]),
          )
        ],
      ),
    );
  }

  Widget _crearPageViewActores(List<Actor> actores) {
    return SizedBox(
        height: 200.0,
        child: PageView.builder(
          pageSnapping: false,
          controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1,
          ),
          itemCount: actores.length,
          itemBuilder: (context, i) {
            return _actorTarjeta(actores[i]);
          },
        ));
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final PeliculasProvider peliProvider = new PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _crearPageViewActores(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget peliculaPoster(
      BuildContext context, Pelicula pelicula, bool isSwiper) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(
                  pelicula.getPosterImg(),
                ),
                height: 150.0,
              ),
            ),
            tag: pelicula.id.toString() + (isSwiper ? '-' : ''),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _appBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          pelicula.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
