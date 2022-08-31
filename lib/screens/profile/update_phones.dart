import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/profile/detail_profile.dart';

class UpdateProfilePhonePage extends StatefulWidget {
  final String title;
  const UpdateProfilePhonePage({Key? key, required this.title})
      : super(key: key);

  @override
  State<UpdateProfilePhonePage> createState() => _UpdateProfilePhonePageState();
}

class _UpdateProfilePhonePageState extends State<UpdateProfilePhonePage> {
  bool _isUpdate = false;
  late String phoneNumbers;
  void toggle() {
    setState(() {
      _isUpdate = !_isUpdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isUpdate) {
      return UpdateProfilePage(
        title: widget.title,
        tapPage: (text) {
          setState(() {
            toggle();
            phoneNumbers = text;
          });
        },
      );
    } else {
      return UpdatePhonePage(
        title: widget.title,
        phoneNumber: phoneNumbers,
        tapPage: () {
          toggle();
        },
      );
    }
  }
}
