import 'package:componentes/models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> lista;

  CardSwiper({
    @required this.lista,
  });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Swiper(
          itemWidth: _screenSize.width * 0.5,
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context, int index) {
            Pelicula pelicula = this.lista[index];
            return Hero(
              tag: pelicula.id.toString() + '-',
              child: ClipRRect(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'movie/detalles',
                        arguments: {'pelicula': pelicula, 'isSwiper': true});
                  },
                  child: FadeInImage(
                    image: NetworkImage(
                      pelicula.getPosterImg(),
                    ),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            );
          },
          itemCount: this.lista.length,
          layout: SwiperLayout.STACK,
        ),
      ),
    );
  }
}
