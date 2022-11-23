import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/auth_page/main_page.dart';
import 'package:flutter_application_coffee/model/onBoard.dart';
import 'package:flutter_application_coffee/screens/onBoarding/components/smooth_indicator.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../helper/animated_page.dart';
import '../register/register_page.dart';
import 'components/child_button.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);
  static String routeName = '/';

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _page = 0;
  late LiquidController _liquidController;

  @override
  void initState() {
    _liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe.builder(
            itemCount: OnBoard.onBoardList.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(OnBoard.onBoardList[index].image),
                        fit: BoxFit.cover)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // Image.asset(
                    //   data[index].image,
                    //   height: 400,
                    //   fit: BoxFit.contain,
                    // ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.2),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Center(
                        child: _liquidController.currentPage ==
                                OnBoard.onBoardList.length - 1
                            ? Column(
                                children: [
                                  firebaseUIButton(
                                      context,
                                      'Wellcome',
                                      Colors.white,
                                      '',
                                      Colors.deepOrange.withOpacity(0.9), () {
                                    Future.delayed(
                                      const Duration(milliseconds: 100),
                                      () {
                                        Navigator.of(context).push(
                                            createRoute(const MainPage()));
                                      },
                                    );
                                  }),
                                ],
                              )
                            : Text(
                                OnBoard.onBoardList[index].slogan,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
            positionSlideIcon: 0.8,
            slideIconWidget:
                _liquidController.currentPage == OnBoard.onBoardList.length - 1
                    ? null
                    : const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
            onPageChangeCallback: (index) {
              setState(() {
                _page = index;
                // print(index);
              });
            },

            waveType: WaveType.liquidReveal,
            liquidController: _liquidController,
            fullTransitionValue: 880,
            enableSideReveal: true,
            enableLoop: false,
            ignoreUserGestureWhileAnimating: true,
            disableUserGesture: false, // not touching the screen
            initialPage: 0,
          ),
          childButtonSkiptoEnd(context, _liquidController),
          childButtonNext(context, _liquidController),
        ],
      ),
    );
  }
}
