import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/auth_page/main_page.dart';
import 'package:flutter_application_coffee/helper/keyboard.dart';
import 'package:flutter_application_coffee/screens/login/components/item_login.dart';
import 'package:flutter_application_coffee/view_models/login-register/login_register.dart';

class BodyLogin extends StatefulWidget {
  final VoidCallback onPressed;
  const BodyLogin({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  final _emaiilController = TextEditingController();
  final _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emaiilController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.bottomLeft,
            //   end: Alignment.topRight,
            //   colors: [
            //     Color(0xFF701ebd),
            //     Color(0xFF873bcc),
            //     Color(0xFFfe4a97),
            //     Color(0xFFe17763),
            //     Color(0xFF68998c)
            //   ],
            // ),
            ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sign In',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ReuseableTextFormField(
                          text: 'Email',
                          icon: Icons.email,
                          isPasswordType: false,
                          controller: _emaiilController),
                      const SizedBox(
                        height: 10,
                      ),
                      ReuseableTextFormField(
                          text: 'Password',
                          icon: Icons.lock,
                          isPasswordType: true,
                          controller: _passwordController),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('pressed ${formKey.currentState!.validate()}');
                          if (formKey.currentState!.validate()) {
                            KeyboardUtil.hideKeyboard(context);
                            signIn(
                                context,
                                _emaiilController.text.toString().trim(),
                                _passwordController.text.toString().trim());
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      firebaseUIButton(context, 'Google', Colors.black,
                          'assets/icons/google.png', Colors.white, () {
                        signInWithGoogle();
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.02,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue,
                              fontSize: size.height * 0.025,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onPressed,
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
