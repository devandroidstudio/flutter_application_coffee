import 'package:flutter/material.dart';

class TestAPI extends StatelessWidget {
  const TestAPI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Test API',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
