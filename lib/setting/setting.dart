import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/home/home_page.dart';
import 'package:flutter_zoom_drawer/config.dart';

class SettingPage extends StatelessWidget {
  const SettingPage(ZoomDrawerController z, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            z.toggle!();
          },
        ),
        title: Text('Setting'),
      ),
      body: Center(
        child: Text('Setting'),
      ),
    );
  }
}
