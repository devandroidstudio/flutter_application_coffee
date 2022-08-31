import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/model/coffee.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CoffeeConceptDetails extends StatefulWidget {
  final Coffee coffee;
  const CoffeeConceptDetails({Key? key, required this.coffee})
      : super(key: key);

  @override
  State<CoffeeConceptDetails> createState() => _CoffeeConceptDetailsState();
}

class _CoffeeConceptDetailsState extends State<CoffeeConceptDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationBtnAdd;
  late Animation<double> _animFooter;
  late Animation<double> _animationScale;
  late Animation<double> _animationTemperature;
  late Animation<double> _animationAppBar;
  bool isTemperature = true;
  bool _isElevated = true;
  Offset distaince = const Offset(4, 4);
  double blur = 30;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _animationAppBar = Tween(begin: 0.0, end: 25.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.9, curve: Curves.easeOut),
      ),
    );
    _animationBtnAdd = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animFooter = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _animationTemperature = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _animationScale = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    super.initState();
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    _isElevated = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                _controller.reverse();
                Navigator.pop(context);
              },
              style: const NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  color: Colors.white,
                  depth: 10,
                  intensity: 0.8,
                  shape: NeumorphicShape.convex),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: _animationAppBar.value,
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
                    intensity: 0.8,
                    shadowLightColor: Colors.black.withOpacity(0.5),
                    oppositeShadowLightSource: false,
                    shape: NeumorphicShape.flat),
                child: NeumorphicButton(
                  minDistance: -10,
                  onPressed: () {},
                  style: const NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                      color: Colors.white,
                      depth: 10,
                      intensity: 0.8,
                      shape: NeumorphicShape.convex),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: _animationAppBar.value,
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
                  child: const Text(
                    '10',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 80),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.antiAlias,
          fit: StackFit.passthrough,
          children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.2),
                      child: Hero(
                        tag: "text_${widget.coffee.name}",
                        child: ScaleTransition(
                          key: Key("text_${widget.coffee.name}"),
                          filterQuality: FilterQuality.high,
                          scale: _animationScale,
                          child: Text(
                            widget.coffee.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Positioned.fill(
              top: size.height * 0.15,
              left: 0,
              right: 0,
              bottom: size.height * 0.28,
              child: Hero(
                tag: widget.coffee.name,
                child: Dismissible(
                  movementDuration: const Duration(milliseconds: 500),
                  resizeDuration: const Duration(milliseconds: 100),
                  key: Key(widget.coffee.name),
                  direction: DismissDirection.down,
                  behavior: HitTestBehavior.translucent,
                  onDismissed: (direction) {
                    Navigator.of(context).pop();
                    _controller.reverse();
                  },
                  child: SizedBox(
                    child: Image.asset(
                      widget.coffee.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
                animation: _controller,
                builder: (context, snapshot) {
                  return Positioned(
                    left: size.width * 0.05,
                    top: size.height * 0.55,
                    bottom: 0,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: 0.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(-100 * value, 240 * value),
                          child: child,
                        );
                      },
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        '\$${widget.coffee.price.toStringAsFixed(2)}',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                shadows: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 20,
                                spreadRadius: 20,
                                blurStyle: BlurStyle.outer,
                              ),
                            ]),
                      ),
                    ),
                  );
                }),
            AnimatedBuilder(
                animation: _controller,
                builder: (context, snapshot) {
                  return Positioned(
                    top: size.height * 0.55,
                    right: 0 + _animationTemperature.value * size.width * 0.158,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: _animationTemperature.value,
                      child: isTemperature
                          ? Image.asset(
                              'assets/images/hot.png',
                              fit: BoxFit.scaleDown,
                            )
                          : Image.asset(
                              'assets/images/ice.png',
                              fit: BoxFit.scaleDown,
                            ),
                    ),
                  );
                }),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  top: size.height * 0.15,
                  right: 0 + _animationBtnAdd.value * size.width * 0.2,
                  child: Listener(
                    onPointerUp: (event) => setState(() {
                      _isElevated = false;
                    }),
                    onPointerDown: (event) => setState(() {
                      _isElevated = true;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: _isElevated
                            ? []
                            : [
                                BoxShadow(
                                  offset: _isElevated
                                      ? const Offset(10, 10)
                                      : -distaince,
                                  color: Colors.white.withOpacity(0.5),
                                  blurRadius: _isElevated ? 5.0 : blur,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  offset: distaince,
                                  color: const Color(0xFFA7A9AF),
                                  blurRadius: _isElevated ? 5.0 : blur,
                                  spreadRadius: 1,
                                )
                              ],
                      ),
                      child: SizedBox(
                        height: size.height * 0.05,
                        width: size.width * 0.1,
                        child: IconButton(
                            splashRadius: 1,
                            onPressed: () {
                              print(_isElevated);
                            },
                            icon: Icon(Icons.add)),
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  bottom: -300 + _animFooter.value * 300,
                  child: SizedBox(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Tamaños
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child:
                                      Image.asset('assets/images/taza_s.png'),
                                ),
                                const Text(
                                  'S',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  margin: const EdgeInsets.only(left: 10),
                                  child:
                                      Image.asset('assets/images/taza_m.png'),
                                ),
                                const Text(
                                  'M',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  margin: const EdgeInsets.only(left: 10),
                                  child:
                                      Image.asset('assets/images/taza_l.png'),
                                ),
                                const Text(
                                  'L',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Hot y cold
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isTemperature = true;
                                  });
                                },
                                child: Text(
                                  'Hot / Warm',
                                  style: TextStyle(
                                      color: isTemperature
                                          ? Colors.brown
                                          : Colors.grey,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 5,
                                color: Colors.grey,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isTemperature = false;
                                  });
                                },
                                child: Text(
                                  'Cold / Ice',
                                  style: TextStyle(
                                      color: isTemperature
                                          ? Colors.grey
                                          : Colors.brown,
                                      fontSize: 24,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
