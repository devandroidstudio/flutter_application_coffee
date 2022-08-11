import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

double _doubleInRange(Random source, num start, num end) =>
    start + source.nextDouble() * (end - start);
final _random = Random();
final coffees = List.generate(
  _name.length,
  (index) => Coffee(
    name: _name[index],
    price: _doubleInRange(_random, 3, 7),
    image: 'assets/images/${index + 1}.png',
  ),
);

final _name = [
  'Caramel Macchiato',
  'Caramel Cold Drink',
  'Iced Coffe Mocha',
  'Caramelized Pecan Latte',
  'Toffee Nut Latte',
  'Capuchino',
  'Toffee Nut Iced Latte',
  'Americano',
  'Vietnamese-Style Iced Coffee',
  'Black Tea Latte',
  'Classic Irish Coffee',
  'Toffee Nut Crunch Latte',
];

class Coffee {
  final String name;
  final double price;
  final String image;

  const Coffee({required this.name, required this.price, required this.image});
}
