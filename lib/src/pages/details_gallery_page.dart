import 'package:flutter/material.dart';

class DetailsGalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final number = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Galeria'),
      ),
      body: Container(
        //padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Hero(
              tag: number,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 240,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage('https://picsum.photos/500/300/?image=$number'),
                    ),
                  ),
                ),
              ),
          ],
        )
      ),
    );
  }
}
