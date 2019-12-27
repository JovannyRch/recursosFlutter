import 'package:flutter/material.dart';
import 'package:componentes/models/pelicula_model.dart';

class HorizontalMovies extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  final _pageController = new PageController(
    keepPage: false,
    initialPage: 1,
    viewportFraction: 0.3,
  );

  HorizontalMovies({@required this.peliculas, @required this.siguientePagina});
  @override
  Widget build(BuildContext context) {
    this._pageController.addListener(() {
      if (this._pageController.position.pixels >
          this._pageController.position.maxScrollExtent - 200) {
        this.siguientePagina();
      }
    });

    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.30,
      child: PageView.builder(
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
          return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final _screenSize = MediaQuery.of(context).size;
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: '${pelicula.id}',
            child: ClipRRect(
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.25,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'movie/detalles',
            arguments: {'pelicula': pelicula, 'isSwiper': false});
      },
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {}).toList();
  }
}
