import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/helper/animated_page.dart';
import 'package:flutter_application_coffee/home_other/home_other_page.dart';
import 'package:flutter_application_coffee/model/coffee.dart';
import 'package:flutter_application_coffee/model/product_cart.dart';
import 'package:flutter_application_coffee/screens/home/components/test.dart';
import 'package:flutter_application_coffee/screens/home/detail_item.dart';
import 'package:flutter_application_coffee/screens/home/home_page.dart';
import 'package:flutter_application_coffee/view_models/login-register/cart_provider.dart';
import 'package:flutter_application_coffee/view_models/login-register/coffee_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'components/bottom_sheet_home_page.dart';

const _duration = Duration(milliseconds: 500);

class CoffeeConceptList extends StatefulWidget {
  final ZoomDrawerController z;
  const CoffeeConceptList({Key? key, required this.z}) : super(key: key);

  @override
  State<CoffeeConceptList> createState() => _CoffeeConceptListState();
}

class _CoffeeConceptListState extends State<CoffeeConceptList> {
  late Box<CoffeeItems> box;
  @override
  void initState() {
    context.read<CoffeeProvider>().init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    box = Hive.box<CoffeeItems>('listProductOfCart');
    super.didChangeDependencies();
  }

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer2<CoffeeProvider, CartProvider>(
        builder: (context, bloc, blocCart, child) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppBarWidget(),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.userChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  foregroundImage: user!.photoURL == null
                                      ? const NetworkImage(
                                          'https://img.icons8.com/pastel-glyph/2x/person-male--v3.png')
                                      : NetworkImage(
                                          '${snapshot.data!.photoURL}',
                                        ),
                                ),
                              ),
                              Text(
                                'Welcome, ${snapshot.data!.displayName}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ),
                Stack(
                  children: [
                    IconButton(
                        splashRadius: 20,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_active_outlined)),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepOrange,
                        ),
                        alignment: Alignment.center,
                        // child: const Text(
                        //   '10',
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: size.height * 0.05,
                  left: 0,
                  right: 0,
                  height: 100,
                  child: const _CoffeeHeader(),
                ),
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

                          if (value >= coffees.length) {
                            Navigator.of(context)
                                .push(createRoute(HomeOtherPage(
                              onTapBack: () {
                                bloc.pageCoffeeController.animateToPage(
                                    value - 1,
                                    duration: _duration,
                                    curve: Curves.easeOut);
                              },
                            )));
                          }
                        },
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const SizedBox.shrink();
                          }
                          final coffee = coffees[index - 1];
                          final result = currentPgae - index + 1;

                          final value = -0.4 * result + 1;
                          final opacity = value.clamp(0.0, 1.0);
                          return GestureDetector(
                            onTap: () {
                              z.close!();
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 650),
                                  pageBuilder: (context, animation, _) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: CoffeeConceptDetails(
                                        coffee: coffee,
                                        onAddCoffees: (values) {
                                          blocCart.addProduct(values, 1);
                                        },
                                        onShowCart: () {
                                          Future.delayed(
                                            const Duration(milliseconds: 200),
                                            () {
                                              showBottomSheetListItemPage(
                                                  context);
                                            },
                                          );
                                        },
                                      ),
                                    );
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
                  right: size.width * 0.05,
                  bottom: size.width * 0.05,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.0, end: 0.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(200 * value, 240 * value),
                        child: child,
                      );
                    },
                    duration: const Duration(milliseconds: 880),
                    child: Stack(
                      children: [
                        Neumorphic(
                          style: const NeumorphicStyle(
                              surfaceIntensity: 0.5,
                              boxShape: NeumorphicBoxShape.circle(),
                              depth: 10,
                              intensity: 0.8,
                              shadowLightColor: Colors.brown,
                              oppositeShadowLightSource: true,
                              lightSource: LightSource.bottomRight,
                              shape: NeumorphicShape.flat),
                          child: NeumorphicButton(
                            minDistance: -10,
                            onPressed: () {
                              showBottomSheetListItemPage(context);
                            },
                            style: const NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.circle(),
                                color: Colors.white,
                                depth: 10,
                                intensity: 0.8,
                                shape: NeumorphicShape.convex),
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                              size: 30,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                        // Contador Carrito
                        Positioned(
                          top: 2,
                          right: 2,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.deepOrange,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              box.values
                                  .fold<int>(
                                      0,
                                      (previousValue, element) =>
                                          previousValue + element.quantity)
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation _menuAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _menuAnimation = Tween(begin: 0.0, end: 25.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.50, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
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
        child: Icon(
          Icons.menu,
          size: _menuAnimation.value,
        ),
      ),
    );
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
            filterQuality: FilterQuality.high,
            offset: Offset(0.0, -120 * value),
            child: child,
          );
        },
        duration: _duration,
        child: ValueListenableBuilder<double>(
          valueListenable: bloc.textPage,
          builder: (context, textPage, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              coffees[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                            ),
                          ));
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: AnimatedSwitcher(
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
                ),
              ],
            );
          },
        ),
      );
    });
  }
}

Future showBottomSheetListItemPage(BuildContext context) async {
  await showModalBottomSheet(
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (context) {
      return const ShowBottomSheetHomePage();
    },
  );
}
