import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/auth_page/main_page.dart';
import 'package:flutter_application_coffee/main.dart';
import 'package:flutter_application_coffee/screens/home/components/test.dart';

final Map<String, WidgetBuilder> routes = {
  MainPage.routeName: (context) => const MainPage(),
  TestAPI.routeName: (context) => const TestAPI(),
  MyApp2.routeName: (context) => const MyApp2(),
};
