import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/model/product_cart.dart';
import 'package:hive/hive.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../view_models/login-register/cart_provider.dart';
import '../home_other_detail_page.dart';

class HomeOtherListPage extends StatefulWidget {
  const HomeOtherListPage({
    Key? key,
    required this.onTapBack,
    required this.bloc,
    required this.onShowCart,
  }) : super(key: key);

  final VoidCallback onTapBack;
  final CartProvider bloc;
  final VoidCallback onShowCart;

  @override
  State<HomeOtherListPage> createState() => _HomeOtherListPageState();
}

class _HomeOtherListPageState extends State<HomeOtherListPage> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final tabs = List.of(widget.bloc.categoryCake.toSet())
        .map((e) => Tab(text: e.toUpperCase()))
        .toList();
    int index = 0;
    void _changeIndex(int indexs) {
      indexs = index + 1;
    }

    // final box = Hive.box<CoffeeItems>('listProductOfCart').values.toList();
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 900),
      length: widget.bloc.categoryCake.length,
      initialIndex: 0,
      child: NestedScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('Other'),
              floating: true,
              snap: true,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 10,
              shadowColor: Colors.black,
              leading: BackButton(onPressed: () {
                widget.onTapBack();
                Navigator.pop(context);
              }),
              bottom: TabBar(
                padding: const EdgeInsets.only(bottom: 1),
                isScrollable: true,
                onTap: _changeIndex,
                tabs: tabs,
                labelColor: Colors.white,
                unselectedLabelColor:
                    const Color.fromARGB(255, 58, 40, 40).withOpacity(0.3),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black),
                labelPadding: const EdgeInsets.symmetric(horizontal: 24),
              ),
            )
          ];
        },
        body: TabBarView(
          clipBehavior: Clip.antiAlias,
          children: [
            StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: widget.bloc.listProduct.length,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 900),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ProductDetails(
                            product: widget.bloc.listProduct[index],
                            onProductAdded: (count) {
                              widget.bloc.addProduct(
                                  widget.bloc.listProduct[index], count);
                            },
                            quantity: widget.bloc.cart.length,
                            onShowCart: () => widget.onShowCart(),
                          ),
                        );
                      },
                    ));
                  },
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Hero(
                              tag: widget.bloc.listProduct[index].name,
                              child: Image.asset(
                                  widget.bloc.listProduct[index].image,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.contain),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            widget.bloc.listProduct[index].name,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: 'Price:\t',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${widget.bloc.listProduct[index].price.toStringAsFixed(2)}\$',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                alignment: Alignment.center,
                                duration: const Duration(seconds: 1),
                                clipBehavior: Clip.hardEdge,
                                width: _isSelected ? 60 : 40,
                                decoration: BoxDecoration(
                                    shape: _isSelected
                                        ? BoxShape.rectangle
                                        : BoxShape.circle,
                                    // borderRadius: _isSelected
                                    //     ? BorderRadius.circular(20)
                                    //     : null,
                                    color: Colors.lightGreen[200]),
                                child: _isSelected
                                    ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            TextButton(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors.green[900],
                                                minimumSize: const Size(20, 20),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.minimize,
                                                size: 10,
                                              ),
                                            ),
                                            const Text('1'),
                                            TextButton(
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors.green[900],
                                                minimumSize: const Size(30, 30),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          widget.bloc.addProduct(
                                              widget.bloc.listProduct[index],
                                              1);
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.green[900],
                                          minimumSize: const Size(30, 30),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 10,
                                        ),
                                      ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(2, index.isEven ? 3 : 2),
            ),
            StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: widget.bloc.listProduct2.length,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 900),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ProductDetails(
                            product: widget.bloc.listProduct2[index],
                            onProductAdded: (count) {
                              widget.bloc.addProduct(
                                  widget.bloc.listProduct2[index], count);
                            },
                            quantity: widget.bloc.cart.length,
                            onShowCart: () => widget.onShowCart(),
                          ),
                        );
                      },
                    ));
                  },
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Hero(
                              tag: widget.bloc.listProduct2[index].name,
                              child: Image.asset(
                                  widget.bloc.listProduct2[index].image,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.contain),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            widget.bloc.listProduct2[index].name,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: 'Price:\t',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${widget.bloc.listProduct2[index].price.toStringAsFixed(2)}\$',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                alignment: Alignment.center,
                                duration: const Duration(seconds: 1),
                                clipBehavior: Clip.hardEdge,
                                width: _isSelected ? 60 : 40,
                                decoration: BoxDecoration(
                                    shape: _isSelected
                                        ? BoxShape.rectangle
                                        : BoxShape.circle,
                                    // borderRadius: _isSelected
                                    //     ? BorderRadius.circular(20)
                                    //     : null,
                                    color: Colors.lightGreen[200]),
                                child: _isSelected
                                    ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            TextButton(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors.green[900],
                                                minimumSize: const Size(20, 20),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.minimize,
                                                size: 10,
                                              ),
                                            ),
                                            const Text('1'),
                                            TextButton(
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors.green[900],
                                                minimumSize: const Size(30, 30),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          widget.bloc.addProduct(
                                              widget.bloc.listProduct2[index],
                                              1);
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.green[900],
                                          minimumSize: const Size(30, 30),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 10,
                                        ),
                                      ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(2, index.isEven ? 3 : 2),
            ),
            Container(
              child: const Center(
                child: Text(
                  'Cetegories',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
