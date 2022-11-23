import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/model/onBoard.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget smoothIndicatorChild(LiquidController liquidController) {
  return AnimatedOpacity(
    duration: const Duration(milliseconds: 300),
    opacity:
        liquidController.currentPage == OnBoard.onBoardList.length - 1 ? 0 : 1,
    child: AnimatedSmoothIndicator(
      textDirection: TextDirection.ltr,
      activeIndex: liquidController.currentPage,
      count: OnBoard.onBoardList.length,
      effect: const ExpandingDotsEffect(
          spacing: 10,
          dotHeight: 10,
          dotWidth: 8,
          dotColor: Colors.white54,
          activeDotColor: Colors.white,
          paintStyle: PaintingStyle.fill,
          expansionFactor: 5),
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 900),
      onDotClicked: (index) {
        liquidController.animateToPage(page: index, duration: 300);
        // print(index);
      },
    ),
  );
}
