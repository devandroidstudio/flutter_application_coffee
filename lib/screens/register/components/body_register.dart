import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/register/components/item_register.dart';
import 'package:flutter_application_coffee/view_models/login-register/login_register.dart';

import '../../onBoarding/components/child_button.dart';

class BodyRegister extends StatefulWidget {
  const BodyRegister({Key? key}) : super(key: key);

  @override
  State<BodyRegister> createState() => _BodyRegisterState();
}

class _BodyRegisterState extends State<BodyRegister> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.02),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ReuseableTextFormField(
                      text: 'Email',
                      icon: Icons.email,
                      isPasswordType: false,
                      controller: _emailController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    ReuseableTextFormField(
                      text: 'User Name',
                      icon: Icons.person,
                      isPasswordType: false,
                      controller: _usernameController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    ReuseableTextFormField(
                      text: 'Phone',
                      icon: Icons.phone,
                      isPasswordType: false,
                      controller: _phoneController,
                      isPhoneType: true,
                    ),
                    SizedBox(height: size.height * 0.01),
                    ReuseableTextFormField(
                      text: 'Password',
                      icon: Icons.lock,
                      isPasswordType: true,
                      controller: _passwordController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    ReuseableTextFormField(
                      text: 'Confirm Password',
                      icon: Icons.lock,
                      isPasswordType: true,
                      controller: _confirmPasswordController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    firebaseUIButton(context, 'Login', Colors.white, '',
                        Colors.deepOrange.withOpacity(0.9), () {
                      if (_formKey.currentState!.validate()) {
                        if (_passwordController.text ==
                            _confirmPasswordController.text) {
                          signUp(
                              context,
                              _emailController.text.toString().trim(),
                              _passwordController.text.toString().trim(),
                              _usernameController.text.toString().trim(),
                              _phoneController.text.toString().trim());
                        }
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
