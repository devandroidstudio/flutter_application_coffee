import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/model/coffee.dart';
import 'package:flutter_application_coffee/screens/home/home_page.dart';
import 'package:flutter_application_coffee/screens/home/list_item.dart';

class MainCoffeeConcept extends StatefulWidget {
  const MainCoffeeConcept({Key? key}) : super(key: key);

  @override
  State<MainCoffeeConcept> createState() => _MainCoffeeConceptState();
}

class _MainCoffeeConceptState extends State<MainCoffeeConcept> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! < -20) {
          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 650),
              pageBuilder: (context, animation, _) {
                return FadeTransition(
                    opacity: animation, child: const HomePage());
              }));
        }
      },
      child: Stack(
        children: [
          const SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0XFFA89276),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            height: size.height * 0.4,
            left: 0,
            right: 0,
            top: size.height * 0.15,
            child: Hero(
              tag: coffees[6].name,
              child: Image.asset(coffees[6].image),
            ),
          ),
          Positioned(
            height: size.height * 0.7,
            left: 0,
            right: 0,
            bottom: 0,
            child: Hero(
              tag: coffees[7].name,
              child: Image.asset(
                coffees[7].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            height: size.height,
            left: 0,
            right: 0,
            bottom: -size.height * 0.7,
            child: Hero(
              tag: coffees[8].name,
              child: Image.asset(
                coffees[8].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            height: 140,
            left: 0,
            right: 0,
            bottom: size.height * 0.3,
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
        ],
      ),
    );
  }
}
