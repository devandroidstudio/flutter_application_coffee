import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/login/components/body_login.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);
  static String routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyLogin(onPressed: showRegisterPage),
      ),
      floatingActionButton: Neumorphic(
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
          child: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
