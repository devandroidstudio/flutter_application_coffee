import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/auth_page/auth_page.dart';
import 'package:flutter_application_coffee/screens/home/components/body_home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static String routeName = '/main';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const MainCoffeeConcept();
              } else {
                return const AuthPage();
              }
            }),
      ),
    );
  }
}
