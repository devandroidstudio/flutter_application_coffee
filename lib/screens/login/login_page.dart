import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/login/components/body_login.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);
  static String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    // final box = Hive.box<String>('isFirstLogin2');
    return Scaffold(
      body: SafeArea(
        child: BodyLogin(onPressed: showRegisterPage),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: Navigator.canPop(context)
          ? Neumorphic(
              style: const NeumorphicStyle(
                  surfaceIntensity: 0.5,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 10,
                  intensity: 0.8,
                  shape: NeumorphicShape.flat),
              child: NeumorphicButton(
                minDistance: -10,
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                style: const NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    color: Colors.white,
                    depth: 10,
                    intensity: 0.8,
                    shape: NeumorphicShape.convex),
                child: const Icon(Icons.arrow_back),
              ),
            )
          : Text(
              'Wellcome Back',
              style: Theme.of(context).textTheme.headline3?.copyWith(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
