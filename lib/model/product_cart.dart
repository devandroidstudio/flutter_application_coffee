import 'package:flutter_application_coffee/model/coffee.dart';
import 'package:hive/hive.dart';
part 'product_cart.g.dart';

@HiveType(typeId: 0)
class Products extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String? size;

  Products({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.size,
  });
}

@HiveType(typeId: 1)
class CoffeeItems extends HiveObject {
  @HiveField(0)
  int quantity;
  @HiveField(1)
  final Products coffees;

  CoffeeItems({required this.coffees, required this.quantity});

  void increments(int count) {
    if (count > 1) {
      quantity = quantity + count;
    } else {
      quantity++;
    }
  }

  void decrements() {
    quantity--;
  }
}
