import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/helper/animated_page.dart';
import 'package:flutter_application_coffee/model/coffee.dart';
import 'package:flutter_application_coffee/screens/home/components/test.dart';
import 'package:flutter_application_coffee/screens/home/detail_item.dart';
import 'package:flutter_application_coffee/screens/home/home_page.dart';
import 'package:flutter_application_coffee/view_models/login-register/coffee_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';

const _duration = Duration(milliseconds: 500);

class CoffeeConceptList extends StatefulWidget {
  const CoffeeConceptList(ZoomDrawerController? z, {Key? key})
      : super(key: key);

  @override
  State<CoffeeConceptList> createState() => _CoffeeConceptListState();
}

class _CoffeeConceptListState extends State<CoffeeConceptList> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<CoffeeProvider>(builder: (context, bloc, child) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Neumorphic(
              style: const NeumorphicStyle(
                  surfaceIntensity: 0.5,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 10,
                  intensity: 0.8,
                  shape: NeumorphicShape.flat),
              child: NeumorphicButton(
                minDistance: -10,
                onPressed: () {
                  z.toggle!();
                },
                style: const NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    color: Colors.white,
                    depth: 10,
                    intensity: 0.8,
                    shape: NeumorphicShape.convex),
                child: const Icon(Icons.menu),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),

              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              // foregroundDecoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.grey,
              //     width: 1,
              //   ),
              //   color: Colors.transparent,
              //   borderRadius: BorderRadius.circular(20),
              // ),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: user!.photoURL != null
                        ? Icon(
                            Icons.person,
                            color: Colors.black,
                          )
                        : Image.network(
                            filterQuality: FilterQuality.high,
                            'https://img.icons8.com/office/2x/guest-male.png',
                            fit: BoxFit.scaleDown,
                          ),
                  ),
                  Text(
                    'Welcome, ${user?.email}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: -size.height * 0.22,
                  height: size.height * 0.3,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.brown,
                            blurRadius: 90,
                            spreadRadius: 60)
                      ],
                    ),
                  ),
                ),
                ValueListenableBuilder<double>(
                  valueListenable: bloc.currentPgae,
                  builder: (context, currentPgae, _) {
                    return Transform.scale(
                      scale: 1.6,
                      alignment: Alignment.bottomCenter,
                      child: PageView.builder(
                        controller: bloc.pageCoffeeController,
                        itemCount: coffees.length + 1,
                        scrollDirection: Axis.vertical,
                        onPageChanged: (value) {
                          if (value < coffees.length) {
                            bloc.pageTextController.animateToPage(value,
                                duration: _duration, curve: Curves.easeInOut);
                          }
                        },
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const SizedBox.shrink();
                          } else if (index > coffees.length + 1) {
                            // print(index);
                            createRoute(context, const TestAPI());
                          }
                          final coffee = coffees[index - 1];
                          final result = currentPgae - index + 1;

                          final value = -0.4 * result + 1;
                          final opacity = value.clamp(0.0, 1.0);

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 650),
                                  pageBuilder: (context, animation, _) {
                                    return FadeTransition(
                                        opacity: animation,
                                        child: CoffeeConceptDetails(
                                          coffee: coffee,
                                        ));
                                  },
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Transform(
                                  alignment: Alignment.bottomCenter,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..translate(
                                      0.0,
                                      size.height / 2.6 * (1 - value).abs(),
                                    )
                                    ..scale(value),
                                  child: Opacity(
                                      opacity: opacity,
                                      child: Hero(
                                        tag: coffee.name,
                                        child: Image.asset(
                                          coffee.image,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ))),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                Positioned(
                  top: size.height * 0.05,
                  left: 0,
                  right: 0,
                  height: 100,
                  child: const _CoffeeHeader(),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _CoffeeHeader extends StatelessWidget {
  const _CoffeeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeProvider>(builder: (context, bloc, child) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: 0.0),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0.0, -100 * value),
            child: child,
          );
        },
        duration: _duration,
        child: ValueListenableBuilder<double>(
          valueListenable: bloc.textPage,
          builder: (context, textPage, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: PageView.builder(
                    allowImplicitScrolling: true,
                    itemCount: coffees.length,
                    controller: bloc.pageTextController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final opacity =
                          (1 - (index - textPage).abs()).clamp(0.0, 1.0);
                      return Opacity(
                          opacity: opacity,
                          child: Hero(
                            tag: "text_${coffees[index].name}",
                            child: Text(
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              coffees[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ));
                    },
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Text(
                    '\$${coffees[textPage.toInt()].price.toStringAsFixed(2)}',
                    key: ValueKey<String>(coffees[textPage.toInt()].name),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
