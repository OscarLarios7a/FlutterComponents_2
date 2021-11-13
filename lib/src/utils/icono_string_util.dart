import 'package:flutter/material.dart';

final _icons = <String, IconData>{

  'add_alert'     : Icons.add_alert,
  'accessibility' : Icons.accessibility,
  'folder_open'   : Icons.folder_open,
  'donut_large'   : Icons.donut_large,
  'input'         : Icons.input,
  'list'          : Icons.list,
  'tune'          : Icons.tune,
  'photo_album_sharp': Icons.photo_album_sharp,
  'photo_camera_back_rounded': Icons.photo_camera_back_rounded,
};




Icon getIcon( String nombreIcono ) {

  return Icon( _icons[nombreIcono], color: Colors.blue );
  
}