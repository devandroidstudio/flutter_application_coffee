import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/helper/keyboard.dart';
import 'package:flutter_application_coffee/screens/profile/components/item_profile.dart';
import 'package:flutter_application_coffee/view_models/main_provider/account_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class UpdateProfilePage extends StatefulWidget {
  static String routeName = '/updateProfile';
  final String title;
  const UpdateProfilePage({Key? key, required this.title}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Neumorphic(
          style: const NeumorphicStyle(
              surfaceIntensity: 0.5,
              boxShape: NeumorphicBoxShape.circle(),
              depth: 10,
              intensity: 0.8,
              shape: NeumorphicShape.flat),
          child: NeumorphicButton(
            minDistance: -10,
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: const NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                color: Colors.white,
                depth: 10,
                intensity: 0.8,
                shape: NeumorphicShape.convex),
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            primary: true,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Divider(
                    color: Colors.grey,
                    thickness: 3,
                    height: 25,
                    indent: 150,
                    endIndent: 150,
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    'New ${widget.title}',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ReuseableTextFormFieldPrifile(
                    icon: Icons.email,
                    controller: controller,
                    isPhoneType: widget.title == 'Phone Number' ? true : false,
                    isPasswordType: widget.title == 'Password' ? true : false,
                    text: widget.title,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                      padding: const EdgeInsets.all(0),
                      animationDuration: const Duration(milliseconds: 300),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 10,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          KeyboardUtil.hideKeyboard(context);
                          updateUser(context, controller.text, widget.title,
                              emailController, passwordController);
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.deepOrange,
                                  Colors.yellowAccent,
                                ],
                                end: Alignment.bottomRight,
                                begin: Alignment.topLeft,
                              )),
                          child: const Text('Update'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
