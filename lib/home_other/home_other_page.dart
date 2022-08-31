import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/home_other/components/app_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class HomeOtherPage extends StatelessWidget {
  const HomeOtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: AppBarHomeOtherPage(),
    );
  }
}
