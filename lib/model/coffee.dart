import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/model/product_cart.dart';
import 'package:meta/meta.dart';

double _doubleInRange(Random source, num start, num end) =>
    start + source.nextDouble() * (end - start);
final _random = Random();
final coffees = List.generate(
  _name.length,
  (index) => Products(
    name: _name[index],
    price: _doubleInRange(_random, 3, 7),
    image: 'assets/images/${index + 1}.png',
    category: 'coffees',
  ),
);
final cakes = List.generate(
  _nameCake.length,
  (index) => Products(
      name: _nameCake[index],
      price: _doubleInRange(_random, 3, 7),
      image: 'assets/images_cake/${index + 1}.png',
      category: 'cakes'),
);
final cakesOther = List.generate(
  _cakeOther.length,
  (index) => Products(
      name: _cakeOther[index],
      price: _doubleInRange(_random, 3, 7),
      image: 'assets/images_cake_other/${index + 1}.png',
      category: 'cakes-other'),
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
final _nameCake = [
  'Mousse Cacao Cake',
  'Peach Mousse Cake',
  'Mousse Chocolate Cake',
  'Coffee Cheese Cake',
  'Caramel Cheese Cake',
  'Banana Cake',
];
final _cakeOther = [
  'Banh Mi',
  'Banh Mi Que Pate',
  'Banh Mi Que Pate Spicy',
];

class Product {
  final String name;
  final double price;
  final String image;
  final String category;
  final String? size;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.size,
  });
}
