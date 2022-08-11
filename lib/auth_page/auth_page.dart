import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/login/login_page.dart';
import 'package:flutter_application_coffee/screens/register/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _showLoginPage = true;
  void togglePage() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoginPage) {
      return LoginPage(
        showRegisterPage: () {
          togglePage();
        },
      );
    } else {
      return RegisterPage(
        showLoginPage: () {
          togglePage();
        },
      );
    }
  }
}
