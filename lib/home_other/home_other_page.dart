import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/home_other/product_cart_detail.dart';
import 'package:flutter_application_coffee/model/product_cart.dart';
import 'package:flutter_application_coffee/view_models/login-register/cart_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'components/home_other_list_page.dart';

const _panelTransition = Duration(milliseconds: 500);

class HomeOtherPage extends StatefulWidget {
  const HomeOtherPage({Key? key, required this.onTapBack}) : super(key: key);
  final VoidCallback onTapBack;

  @override
  State<HomeOtherPage> createState() => _HomeOtherPageState();
}

class _HomeOtherPageState extends State<HomeOtherPage> {
  final bloc = CartProvider();
  bool isDraggable = false;
  late CoffeeItems coffeeItems;
  @override
  void initState() {
    super.initState();
  }

  void _onVeriticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -7) {
      bloc.changeToCart();
    } else if (details.primaryDelta! > 12) {
      bloc.changeToNormal();
    }
  }

  double _getTopForWhitePanel(ProductState state, Size size) {
    if (state == ProductState.normal) {
      return 0.0;
    } else if (state == ProductState.cart) {
      return -(size.height - 150.0 / 2);
    }
    return 0.0;
  }

  double _getTopForBlackPanel(ProductState state, Size size) {
    if (state == ProductState.normal) {
      return size.height - 80;
    } else if (state == ProductState.cart) {
      return 150.0 / 2;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CartBloc(
        bloc: bloc,
        child: AnimatedBuilder(
            animation: bloc,
            builder: (context, _) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              curve: Curves.decelerate,
                              duration: _panelTransition,
                              top: _getTopForWhitePanel(bloc.state, size),
                              left: 0,
                              right: 0,
                              height: bloc.state == ProductState.cart
                                  ? size.height
                                  : size.height - 80,
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30))),
                                child: HomeOtherListPage(
                                  onTapBack: widget.onTapBack,
                                  bloc: bloc,
                                  onShowCart: () {
                                    Future.delayed(
                                      const Duration(milliseconds: 200),
                                      () {
                                        setState(() {
                                          bloc.state = ProductState.cart;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                              curve: Curves.decelerate,
                              duration: _panelTransition,
                              left: 0,
                              right: 0,
                              height: size.height - 100,
                              top: _getTopForBlackPanel(bloc.state, size),
                              child: GestureDetector(
                                onVerticalDragUpdate: _onVeriticalGesture,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.rectangle),
                                  child: Column(
                                    children: [
                                      AnimatedSwitcher(
                                        duration: _panelTransition,
                                        child: SizedBox(
                                          width: size.width - 10,
                                          height: 80,
                                          child:
                                              bloc.state == ProductState.normal
                                                  ? Row(
                                                      children: [
                                                        const Text(
                                                          "Cart",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25),
                                                        ),
                                                        Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0,
                                                                  vertical: 10),
                                                              child: Row(
                                                                children: List
                                                                    .generate(
                                                                  bloc.cart
                                                                      .length,
                                                                  (index) =>
                                                                      LongPressDraggable(
                                                                    feedback:
                                                                        FractionalTranslation(
                                                                      translation: const Offset(
                                                                          -0.5,
                                                                          -0.5),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            60,
                                                                        height:
                                                                            60,
                                                                        child: Image.asset(bloc
                                                                            .cart
                                                                            .values
                                                                            .toList()[index]
                                                                            .coffees
                                                                            .image),
                                                                      ),
                                                                    ),
                                                                    onDragStarted:
                                                                        () {
                                                                      coffeeItems = bloc
                                                                          .cart
                                                                          .values
                                                                          .toList()[index];
                                                                      bloc.deleteProduct(bloc
                                                                          .cart
                                                                          .values
                                                                          .toList()[index]);

                                                                      setState(
                                                                          () {
                                                                        isDraggable =
                                                                            true;
                                                                        print(
                                                                            '${bloc.cart.keys}');
                                                                      });
                                                                    },
                                                                    onDraggableCanceled:
                                                                        (velocity,
                                                                            offset) {
                                                                      print(
                                                                          index);
                                                                      print(coffeeItems
                                                                          .coffees
                                                                          .name);
                                                                      setState(
                                                                          () {
                                                                        isDraggable =
                                                                            false;
                                                                      });
                                                                      bloc.addProduct(
                                                                          coffeeItems
                                                                              .coffees,
                                                                          1);
                                                                    },
                                                                    data: bloc
                                                                        .cart
                                                                        .values
                                                                        .toList()[index],
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Hero(
                                                                            tag:
                                                                                "${bloc.cart.values.toList()[index].coffees.name}details",
                                                                            child:
                                                                                CircleAvatar(
                                                                              backgroundColor: Colors.white,
                                                                              backgroundImage: AssetImage(
                                                                                bloc.cart.values.toList()[index].coffees.image,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Positioned(
                                                                            right:
                                                                                0,
                                                                            child:
                                                                                CircleAvatar(
                                                                              radius: 9.0,
                                                                              backgroundColor: Colors.red,
                                                                              child: Text(
                                                                                bloc.cart.values.toList()[index].quantity.toString(),
                                                                                style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.yellow,
                                                          child: Text(bloc
                                                              .totalCartElements()
                                                              .toString()),
                                                        )
                                                      ],
                                                    )
                                                  : const SizedBox.shrink(),
                                        ),
                                      ),
                                      GroceryStoreCart(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
