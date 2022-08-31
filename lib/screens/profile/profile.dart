import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/home/home_page.dart';
import 'package:flutter_application_coffee/screens/profile/components/body_profile.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_zoom_drawer/config.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(ZoomDrawerController z, {Key? key}) : super(key: key);
  static String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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
            z.toggle!();
          },
          style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              color: Colors.white,
              depth: 10,
              intensity: 0.8,
              shape: NeumorphicShape.convex),
          child: const Icon(Icons.menu),
        ),
      ),
      body: const SafeArea(
        child: BodyProfile(),
      ),
    );
  }
}
