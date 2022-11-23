import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/model/coffee.dart';
import 'package:flutter_application_coffee/model/product_cart.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

enum ProductState {
  normal,
  detail,
  cart,
}

class CartProvider extends ChangeNotifier {
  ProductState state = ProductState.normal;
  List<Products> listProduct = List.unmodifiable(cakes);
  List<Products> listProduct2 = List.unmodifiable(cakesOther);
  List<String> categoryCake = ['New Cakes', 'cakes-other', 'tea'];
  late Box<CoffeeItems> cart;
  CartProvider() {
    cart = Hive.box<CoffeeItems>('listProductOfCart');
  }

  void changeToNormal() {
    state = ProductState.normal;
    notifyListeners();
  }

  void changeToCart() {
    state = ProductState.cart;
    notifyListeners();
  }

  void addProduct(Products product, int count) {
    for (CoffeeItems item in cart.values.toList()) {
      if (item.coffees.name == product.name) {
        item.increments(count);
        notifyListeners();
        return;
      }
    }
    cart.add(CoffeeItems(coffees: product, quantity: count));
    notifyListeners();
  }

  void removeProduct(Products product, BuildContext context) {
    for (CoffeeItems item in cart.values.toList()) {
      if (item.coffees.name == product.name) {
        item.decrements();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  void deleteProduct(CoffeeItems productItem) {
    // cart.remove(productItem);
    cart.deleteAt(cart.values.toList().indexOf(productItem));
    // box.remove(productItem);
    notifyListeners();
  }

  int totalCartElements() => cart.values.fold<int>(
      0, (previousValue, element) => previousValue + element.quantity);
  double totalPriceElements() => cart.values.fold<double>(
      0.0,
      (previousValue, element) =>
          previousValue + (element.quantity * element.coffees.price));

  static CartProvider? of(BuildContext context) {
    return Provider.of<CartProvider>(context, listen: false);
  }

  @override
  void dispose() {
    Hive.box('listProductOfCart').close();
    super.dispose();
  }
}

class CartBloc extends InheritedWidget {
  final CartProvider bloc;
  final Widget child;

  const CartBloc({super.key, required this.bloc, required this.child})
      : super(child: child);
  static CartBloc? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CartBloc>();
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
