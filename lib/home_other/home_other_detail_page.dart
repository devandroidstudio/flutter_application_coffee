import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/home_other/components/app_bar.dart';
import 'package:flutter_application_coffee/model/coffee.dart';
import 'package:flutter_application_coffee/model/product_cart.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails(
      {super.key,
      required this.product,
      this.onProductAdded,
      this.quantity,
      required this.onShowCart});
  final Products product;
  final Function(int)? onProductAdded;
  final int? quantity;
  final VoidCallback onShowCart;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String heroTag = '';
  int count = 1;
  void _addToCart(BuildContext context) {
    setState(() {
      heroTag = "details";
    });
    widget.onProductAdded!(count);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: const EdgeInsets.only(top: 100, bottom: 20),
              elevation: 10,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Hero(
                tag: widget.product.name + heroTag,
                child: Image.asset(
                  widget.product.image,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  isAntiAlias: true,
                ),
              ),
            ),
            Text(
              widget.product.name,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text.rich(
              TextSpan(
                text: 'Price:\t',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.black, fontStyle: FontStyle.italic),
                children: [
                  TextSpan(
                    text: '${widget.product.price.toStringAsFixed(2)}\$',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantity:',
                  style: style.headline5?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 40,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                if (count <= 1) {
                                  count = 1;
                                } else {
                                  count--;
                                }
                              });
                            },
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            minWidth: 50,
                            child: const Icon(Icons.remove),
                          ),
                          Text(count.toString()),
                          MaterialButton(
                              clipBehavior: Clip.hardEdge,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              onPressed: () {
                                setState(() {
                                  count++;
                                });
                              },
                              minWidth: 50,
                              splashColor: Colors.grey[300],
                              child: const Icon(Icons.add)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () => _addToCart(context),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text("Add to Cart"),
                )),
            const Spacer()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: AppBarHomeOtherDetailPage(
        quantity: widget.quantity!,
        onShowCart: () {
          widget.onShowCart();
        },
      ),
    );
  }
}
