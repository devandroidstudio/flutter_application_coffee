import 'package:flutter/material.dart';

class OnBoard {
  final String image;
  final String slogan;

  OnBoard({required this.image, required this.slogan});

  static List<OnBoard> onBoardList = [
    OnBoard(
      image: 'assets/image_onBoard/1.jpg',
      slogan: 'Welcome to Coffee Application',
    ),
    OnBoard(
      image: 'assets/image_onBoard/2.jpg',
      slogan:
          'They say coffee keeps you from getting bored. But really it’s just to make the day longer.',
    ),
    OnBoard(
      image: 'assets/image_onBoard/3.jpg',
      slogan:
          'Your cup of coffee is sad. It’s just sitting there all alone. Please make better coffee choices.',
    ),
    OnBoard(
      image: 'assets/image_onBoard/4.jpg',
      slogan: '',
      // slogan: 'Coffee Your Life!',
    ),
  ];
}
