import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppBarHomeOtherPage extends StatelessWidget {
  const AppBarHomeOtherPage({Key? key, required this.onTapBack})
      : super(key: key);
  final VoidCallback onTapBack;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
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
                onTapBack();
                Navigator.pop(context);
              },
              style: const NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  color: Colors.white,
                  depth: 10,
                  intensity: 0.8,
                  shape: NeumorphicShape.convex),
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarHomeOtherDetailPage extends StatelessWidget {
  const AppBarHomeOtherDetailPage(
      {Key? key, required this.quantity, required this.onShowCart})
      : super(key: key);
  final int quantity;
  final VoidCallback onShowCart;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
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
                Navigator.pop(context);
              },
              style: const NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  color: Colors.white,
                  depth: 10,
                  intensity: 0.8,
                  shape: NeumorphicShape.convex),
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
          Stack(
            children: [
              Neumorphic(
                style: NeumorphicStyle(
                    surfaceIntensity: 0.5,
                    boxShape: const NeumorphicBoxShape.circle(),
                    depth: 10,
                    intensity: 0.6,
                    shadowLightColor: Colors.black.withOpacity(0.5),
                    oppositeShadowLightSource: false,
                    shape: NeumorphicShape.flat),
                child: NeumorphicButton(
                  minDistance: -10,
                  onPressed: () {
                    Navigator.pop(context);
                    onShowCart();
                  },
                  style: const NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                      color: Colors.white,
                      depth: 10,
                      intensity: 0.8,
                      shape: NeumorphicShape.convex),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 25,
                    color: Colors.brown,
                  ),
                ),
              ),
              // Contador Carrito
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrange,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    quantity.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
