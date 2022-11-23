import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/helper/animated_page.dart';
import 'package:flutter_application_coffee/home_other/components/item_home_other.dart';
import 'package:flutter_application_coffee/model/payment.dart';
import 'package:flutter_application_coffee/view_models/login-register/cart_provider.dart';

class GroceryStoreCart extends StatefulWidget {
  const GroceryStoreCart({
    Key? key,
  }) : super(key: key);

  @override
  State<GroceryStoreCart> createState() => _GroceryStoreCartState();
}

class _GroceryStoreCartState extends State<GroceryStoreCart> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  void remove(int index) {
    _listKey.currentState?.removeItem(index, (context, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.red,
          child: const ListTile(
            title: Text("Delete"),
            leading: Icon(Icons.delete),
          ),
        ),
      );
    }, duration: const Duration(milliseconds: 500));
  }

  late Payment payment;

  @override
  void initState() {
    for (var element in listPayments) {
      if (element.isSelected == true) {
        payment = element;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = CartBloc.of(context)!.bloc;
    return Expanded(
        child: AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: bloc.state == ProductState.cart
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Cart',
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Expanded(
                        child: bloc.cart.isNotEmpty
                            ? AnimatedList(
                                key: _listKey,
                                initialItemCount: bloc.cart.length,
                                itemBuilder: (context, index, animation) {
                                  return SizeTransition(
                                    sizeFactor: animation,
                                    key: UniqueKey(),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      color: Colors.black,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Image.asset(
                                                      bloc.cart.values
                                                          .toList()[index]
                                                          .coffees
                                                          .image,
                                                      fit: BoxFit.scaleDown,
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      width: 20),
                                                ),
                                                title: Text.rich(
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  TextSpan(
                                                      text: bloc.cart.values
                                                          .toList()[index]
                                                          .quantity
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      children: [
                                                        const TextSpan(
                                                            text: ' x '),
                                                        TextSpan(
                                                            text: bloc
                                                                .cart.values
                                                                .toList()[index]
                                                                .coffees
                                                                .name)
                                                      ]),
                                                ),
                                              ),
                                            ),
                                            MaterialButton(
                                                splashColor: Colors.grey[300],
                                                minWidth: 10,
                                                onPressed: () {
                                                  bloc.cart.values
                                                              .toList()[index]
                                                              .quantity <=
                                                          1
                                                      ? null
                                                      : bloc.removeProduct(
                                                          bloc.cart.values
                                                              .toList()[index]
                                                              .coffees,
                                                          context);
                                                },
                                                child: Text(
                                                  '-',
                                                  style: TextStyle(
                                                      color: bloc.cart.values
                                                                  .toList()[
                                                                      index]
                                                                  .quantity <=
                                                              1
                                                          ? Colors.black
                                                          : Colors.white),
                                                )),
                                            MaterialButton(
                                                minWidth: 10,
                                                onPressed: () {
                                                  bloc.addProduct(
                                                      bloc.cart.values
                                                          .toList()[index]
                                                          .coffees,
                                                      1);
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 10,
                                                )),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                  '\$${(bloc.cart.values.toList()[index].quantity * bloc.cart.values.toList()[index].coffees.price).toStringAsFixed(2)}',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  bloc.deleteProduct(bloc
                                                      .cart.values
                                                      .toList()[index]);

                                                  remove(index);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  "Empty",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      const Spacer(),
                      Text(
                        "\$${bloc.totalPriceElements().toStringAsFixed(2)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                          dense: true,
                          onTap: () {
                            Navigator.push(
                                context, createRoute(const PreferentialPage()));
                          },
                          leading: const Icon(Icons.celebration_rounded),
                          title: const Text('Super Save with Preferential'),
                          trailing: const Icon(Icons.chevron_right)),
                      const Divider(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: MaterialButton(
                              highlightColor: Colors.white,
                              splashColor: Colors.white,
                              onPressed: () async {
                                Payment paymentCurrent =
                                    await showBottomSheetPaymentPage(context);
                                setState(() {
                                  payment = paymentCurrent;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(payment.images, scale: 2.5),
                                  Text(
                                    payment.name,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  const Icon(Icons.keyboard_arrow_up),
                                  const Text('|')
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                    backgroundColor: const Color(0xffDCE2F0),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))),
                                clipBehavior: Clip.antiAlias,
                                onPressed: () {},
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'Pay',
                                    style:
                                        Theme.of(context).textTheme.bodyText1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          : const SizedBox.shrink(),
    ));
  }
}

class PreferentialPage extends StatelessWidget {
  const PreferentialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text('Preferential'),
        backgroundColor: Colors.white,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return const ListTile();
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 3),
    );
  }
}
