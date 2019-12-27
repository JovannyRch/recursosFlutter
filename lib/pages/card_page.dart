import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Card Page"),
        ),
        body: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            _card1(),
            SizedBox(
              height: 10.0,
            ),
            _card2()
          ],
        ),
      ),
    );
  }

  Widget _card2() {
    final card = Container(
      child: Column(
        children: <Widget>[
          /* Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/3/37/Catedral_Toluca.jpg'), */
          FadeInImage(
            image: NetworkImage(
                'https://upload.wikimedia.org/wikipedia/commons/3/37/Catedral_Toluca.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fit: BoxFit.fill,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text("hola"),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 2.0,
              spreadRadius: 2.0,
              offset: Offset(-10, 10))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: card,
      ),
    );
  }

  Widget _card1() {
    return Card(
      elevation: 10.0,
      // shape: ShapeBorder(),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.photo_album,
              color: Colors.blue,
            ),
            title: Text("Soy el título"),
            subtitle: Text("Soy el subtítulo"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("Cancelar", style: TextStyle(color: Colors.blue)),
                onPressed: () {},
              ),
              FlatButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
