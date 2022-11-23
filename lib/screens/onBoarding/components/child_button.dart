import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/model/onBoard.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

Container firebaseUIButton(BuildContext context, String title,
    Color? colorTitle, String? icon, Color color, VoidCallback onTap) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.55,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return color.withOpacity(0.5);
            }
            return color;
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Colors.white)),
        ),
      ),
      child: ListTile(
        leading: icon.toString().isEmpty
            ? null
            : Image.asset(
                icon!,
                width: 30,
                height: 30,
              ),
        title: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (rect) => icon.toString().isNotEmpty
              ? const LinearGradient(
                      colors: [Colors.indigoAccent, Colors.pink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      tileMode: TileMode.mirror)
                  .createShader(rect)
              : LinearGradient(
                      colors: [colorTitle!, colorTitle],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      tileMode: TileMode.mirror)
                  .createShader(rect),
          child: Text(
            textAlign:
                icon.toString().isEmpty ? TextAlign.center : TextAlign.left,
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Roboto'),
          ),
        ),
      ),
    ),
  );
}

Widget childButtonNext(
    BuildContext context, LiquidController liquidController) {
  return AnimatedPositioned(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    right: liquidController.currentPage == OnBoard.onBoardList.length - 1
        ? -MediaQuery.of(context).size.width
        : 0,
    bottom: 0,
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          clipBehavior: Clip.antiAlias,
          onPressed: () {
            liquidController.animateToPage(
                page: liquidController.currentPage + 1 >
                        OnBoard.onBoardList.length - 1
                    ? 0
                    : liquidController.currentPage + 1);
          },
          child: Text("Next",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    ),
  );
}

Widget childButtonSkiptoEnd(
    BuildContext context, LiquidController liquidController) {
  return AnimatedOpacity(
    curve: Curves.easeInOut,
    opacity: liquidController.currentPage == OnBoard.onBoardList.length - 1
        ? 0.0
        : 1.0,
    duration: const Duration(milliseconds: 300),
    child: Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 8,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            liquidController.animateToPage(
                page: OnBoard.onBoardList.length - 1, duration: 700);
          },
          child: Text(
            "Skip to End",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}
