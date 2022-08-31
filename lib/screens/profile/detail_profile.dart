import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/helper/keyboard.dart';
import 'package:flutter_application_coffee/screens/profile/components/item_profile.dart';
import 'package:flutter_application_coffee/view_models/main_provider/account_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UpdateProfilePage extends StatefulWidget {
  static String routeName = '/updateProfile';
  final String title;
  final Function tapPage;
  const UpdateProfilePage(
      {Key? key, required this.title, required this.tapPage})
      : super(key: key);

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
                          if (widget.title.contains('Phone Number')) {
                            widget.tapPage(controller.text);
                          } else {
                            KeyboardUtil.hideKeyboard(context);
                            updateUser(context, controller.text, widget.title,
                                emailController, passwordController);
                          }
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

class UpdatePhonePage extends StatefulWidget {
  final String title;
  final String? phoneNumber;
  final VoidCallback tapPage;
  const UpdatePhonePage(
      {Key? key, required this.title, this.phoneNumber, required this.tapPage})
      : super(key: key);

  @override
  State<UpdatePhonePage> createState() => _UpdatePhonePageState();
}

class _UpdatePhonePageState extends State<UpdatePhonePage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final TextEditingController textController = TextEditingController();
  String? currentCode;
  StreamController<ErrorAnimationType>? errorController;

  verifify() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          setState(() {
            print(credential.smsCode);
          });

          await FirebaseAuth.instance.currentUser!
              .updatePhoneNumber(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          showDialogCode(e.code);
        },
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(milliseconds: 10));
  }

  showDialogCode(String e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Warning'),
        content: Text(e.toString().split(']')[1]),
        actions: [
          ElevatedButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldkey,
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
                setState(() {
                  widget.tapPage();
                });
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
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 80),
            primary: true,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // const Divider(
                  //   color: Colors.grey,
                  //   thickness: 3,
                  //   height: 25,
                  //   indent: 150,
                  //   endIndent: 150,
                  // ),
                  Text(
                    'New ${widget.title}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        backgroundColor: Colors.transparent,

                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        // obscureText: true,
                        // obscuringCharacter: '*',
                        // obscuringWidget: const FlutterLogo(
                        //   size: 24,
                        // ),
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,

                        validator: (v) {
                          if (v!.length < 3 || v.isEmpty) {
                            return "Please fill up all the cells properly";
                          } else {
                            return showDialogCode(v);
                          }
                        },
                        pinTheme: PinTheme(
                          inactiveFillColor: Colors.white,
                          selectedColor: Colors.greenAccent,
                          selectedFillColor: Colors.white,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textController,
                        keyboardType: TextInputType.number,

                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          debugPrint("Completed $v");
                          setState(() {
                            currentCode = v;
                          });
                        },

                        onTap: () {
                          print("Pressed");
                        },
                        onChanged: (value) {
                          debugPrint(value);
                          // setState(() {
                          //   currentText = value;
                          // });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");

                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),

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

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Warning'),
                              content: Text(currentCode.toString()),
                              actions: [
                                ElevatedButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          errorController!.add(ErrorAnimationType.shake);
                        }
                      },
                      child: Container(
                        constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width * 0.5),
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
                        child: const Text('Submit'),
                        alignment: Alignment.center,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
