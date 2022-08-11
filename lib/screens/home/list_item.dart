import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/model/coffee.dart';
import 'package:flutter_application_coffee/screens/home/detail_item.dart';
import 'package:flutter_application_coffee/view_models/login-register/coffee_provider.dart';
import 'package:provider/provider.dart';

const _duration = Duration(milliseconds: 500);

class CoffeeConceptList extends StatefulWidget {
  const CoffeeConceptList({Key? key}) : super(key: key);

  @override
  State<CoffeeConceptList> createState() => _CoffeeConceptListState();
}

class _CoffeeConceptListState extends State<CoffeeConceptList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<CoffeeProvider>(builder: (context, bloc, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Hello world"),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const BackButton(color: Colors.black),
        ),
        body: SafeArea(
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
                          color: Colors.brown, blurRadius: 90, spreadRadius: 60)
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
                        if (index == 0 || index > coffees.length) {
                          return const SizedBox.shrink();
                        }
                        final coffee = coffees[index - 1];
                        final result = currentPgae - index + 1;

                        final value = -0.4 * result + 1;
                        final opacity = value.clamp(0.0, 1.0);

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 650),
                                pageBuilder: (context, animation, _) {
                                  return FadeTransition(
                                      opacity: animation,
                                      child: CoffeeConceptDetails(
                                        coffee: coffee,
                                      ));
                                }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
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
              // const Positioned(
              //   top: 0,
              //   left: 0,
              //   right: 0,
              //   height: 100,
              //   child: _CoffeeHeader(),
              // )
            ],
          ),
        ),
      );
    });
  }
}

// class _CoffeeHeader extends StatelessWidget {
//   const _CoffeeHeader({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
    
//     final size = MediaQuery.of(context).size;
//     return Consumer<CoffeeProvider>(
//       builder: (context, bloc, child) {
//         return TweenAnimationBuilder<double>(
//           tween: Tween(begin: 1.0, end: 0.0),
//           builder: (context, value, child) {
//             return Transform.translate(
//               offset: Offset(0.0, -100 * value),
//               child: child,
//             );
//           },
//           duration: _duration,
//           child: ValueListenableBuilder<double>(
//               valueListenable: bloc.textPage,
//               builder: (context, textPage, _) {
//                 return Column(
//                   children: [
//                     Expanded(
//                       child: PageView.builder(
//                         itemCount: coffees.length,
//                         controller: bloc.pageTextController,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           final opacity =
//                               (1 - (index - textPage).abs()).clamp(0.0, 1.0);
//                           return Opacity(
//                               opacity: opacity,
//                               child: Hero(
//                                 tag: "text_${coffees[index].name}",
//                                 child: Text(
//                                   maxLines: 2,
//                                   textAlign: TextAlign.center,
//                                   coffees[index].name,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headline5
//                                       ?.copyWith(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                 ),
//                               ));
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 500),
//                       transitionBuilder:
//                           (Widget child, Animation<double> animation) {
//                         return ScaleTransition(scale: animation, child: child);
//                       },
//                       child: Text(
//                         '\$${coffees[textPage.toInt()].price.toStringAsFixed(2)}',
//                         key: ValueKey<String>(coffees[textPage.toInt()].name),
//                         style: Theme.of(context).textTheme.headline4,
//                       ),
//                     ),
//                   ],
//                 );
//               }),
//         );
//       }
//     );
//   }
// }
