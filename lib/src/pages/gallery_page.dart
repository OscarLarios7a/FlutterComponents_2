import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryPage extends StatefulWidget {
  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int _lastItem = 0; //? el valor del ultimo Item que se agrega al Grid
  List<int> imagenes = []; //?  se crea un arreglo en forma de lista vacio
  bool _final = false;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
    _addItem();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Galeria Images'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: _galleryImg(),
        ),
        //?Agregamos un nuevo boton
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              _final ? Colors.blue : Colors.grey, //* se ocupa un ciclo ternario
          child: Icon(Icons.add_circle_outlined),
          onPressed: _final
              ? () {
                  _addItem();
                  setState(() {});
                }
              : null,
        ));
  }

  Widget _galleryImg() {
    return RefreshIndicator(
      onRefresh: _newGalleryImagen,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: imagenes.length,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context, 'details_gallery',
                arguments: imagenes[index],
              );
            },
            child: Hero(
              tag: imagenes[index],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: index.isEven ? 200 : 400,
                  //color: Colors.amberAccent.shade700,
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(
                        'https://picsum.photos/500/300/?image=${imagenes[index]}'),
                  ),
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        mainAxisSpacing: 10,
        crossAxisSpacing: 20,
      ),
    );
  }

  void _addItem() {
    for (var i = 0; i < 15; i++) {
      _lastItem++;
      imagenes.add(_lastItem);
      setState(() {});
    }
  }

  _listener() {
    final maxScroll = _controller.position.maxScrollExtent;
    final minScroll = _controller.position.minScrollExtent;
    if (_controller.offset >= maxScroll) {
      print('Ya estas al final');
      setState(() {
        _final = true;
      });
    }
  }

  Future<Null> _newGalleryImagen() async {
    final _duration = Duration(seconds: 2);

    new Timer(_duration, () {
      imagenes.clear();
      _lastItem++;
      _addItem();
    });
    return Future.delayed(_duration);
  }
}
