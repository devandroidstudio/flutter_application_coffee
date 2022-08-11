import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double _initalPage = 8.0;

class CoffeeProvider extends ChangeNotifier {
  final pageCoffeeController =
      PageController(viewportFraction: 0.35, initialPage: _initalPage.toInt());
  final pageTextController = PageController(initialPage: _initalPage.toInt());
  final currentPgae = ValueNotifier<double>(_initalPage);
  final textPage = ValueNotifier<double>(_initalPage);
  CoffeeProvider() {
    init();
  }

  void init() {
    currentPgae.value = _initalPage;
    textPage.value = _initalPage;
    pageCoffeeController.addListener(_coffeeScrollListener);
    pageTextController.addListener(_textScrollListener);
  }

  void _coffeeScrollListener() {
    currentPgae.value = pageCoffeeController.page!;
  }

  void _textScrollListener() {
    textPage.value = pageTextController.page!;
  }

  void dispose() {
    pageCoffeeController.removeListener(_coffeeScrollListener);
    pageTextController.removeListener(_textScrollListener);
    pageCoffeeController.dispose();
    pageTextController.dispose();
  }

  static CoffeeProvider? of(BuildContext context) {
    return Provider.of<CoffeeProvider>(context, listen: false);
  }
}
