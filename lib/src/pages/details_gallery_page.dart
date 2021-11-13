import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

class DetailsGalleryPage extends StatelessWidget {
  //const DetailsGalleryPage({key}) : super(key: key);
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //String get subDirectory => null;

  @override
  Widget build(BuildContext context) {
    final number = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Detalle Galeria'),
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Hero(
                tag: number,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                              offset: Offset(2.0, 10.0))
                        ]),
                    height: 240,
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(
                          'https://picsum.photos/500/300/?image=$number'),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    // Saved with this method.
                    var imageId = await ImageDownloader.downloadImage(
                        'https://picsum.photos/500/300/?image=$number', destination: AndroidDestinationType.custom(directory: 'sample')
                          .. inExternalFilesDir()
                          ..subDirectory("custom/$number"));

                    final _msg = ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Imagen Descargada!!'),
                      ),
                    );
                    //_key=_msg as GlobalKey<ScaffoldState>;
                    if (imageId == null) {
                      return;
                    }
                  } on PlatformException catch (error) {
                    print(error);
                  }
                },
                child: Icon(Icons.download_for_offline),
              ),
            ],
          )),
    );
  }
}
