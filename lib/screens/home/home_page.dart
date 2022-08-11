import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/home/components/body_home_page.dart';
import 'package:flutter_application_coffee/view_models/login-register/coffee_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(providers: [
          ChangeNotifierProvider<CoffeeProvider>.value(value: CoffeeProvider()),
        ], child: const MainCoffeeConcept()),
      ),
    );
  }
}
