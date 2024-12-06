import 'package:flutter/material.dart';

class GameGridView<T> {
   String _title;
   String _image;
   String _route;

   String get route => _route;

  set route(String value) {
    _route = value;
  }

   String get image => _image;

  set image(String value) {
    _image = value;
  }

   String get title => _title;

  set title(String value) {
    _title = value;
  }

   GameGridView(this._title, this._image, this._route);
}
