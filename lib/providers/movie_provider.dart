import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  MovieProvider() {
    print("MovieProvider initialized");
    getDisplayMovie();
  }

  getDisplayMovie() async {
    print("getDisplayMovie");
  }
}
