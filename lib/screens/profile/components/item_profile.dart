import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/profile/detail_profile.dart';

class ReuseButtonProfile extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const ReuseButtonProfile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
          borderRadius: title.contains('Email')
              ? const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))
              : title.contains('Password')
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))
                  : const BorderRadius.all(Radius.zero),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.black,
            )),
        trailing:
            const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
        subtitle: Text(title.contains('Password') ? '*******' : subtitle),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class ReuseableTextFormFieldPrifile extends StatefulWidget {
  final String text;
  final IconData icon;
  bool isPasswordType;
  bool? isPhoneType;
  final TextEditingController controller;
  ReuseableTextFormFieldPrifile({
    Key? key,
    required this.text,
    required this.icon,
    required this.isPasswordType,
    required this.controller,
    this.isPhoneType,
  }) : super(key: key);

  @override
  State<ReuseableTextFormFieldPrifile> createState() =>
      _ReuseableTextFormFieldPrifile();
}

class _ReuseableTextFormFieldPrifile
    extends State<ReuseableTextFormFieldPrifile> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordType,
      enableSuggestions: !widget.isPasswordType,
      autocorrect: !widget.isPasswordType,
      cursorColor: Colors.deepPurpleAccent,
      maxLength: widget.text.contains('Phone') ? 10 : null,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        errorMaxLines: 20,
        errorStyle: const TextStyle(color: Colors.red),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
        alignLabelWithHint: true,
        prefixIcon: Icon(
          widget.icon,
          color: Colors.deepPurple.withOpacity(0.8),
        ),
        prefixIconColor: Colors.black,
        suffixIcon: widget.isPasswordType
            ? widget.controller.text.isNotEmpty
                ? IconButton(
                    icon: widget.isPasswordType
                        // ignore: dead_code
                        ? Icon(
                            Icons.visibility_off,
                            color: Colors.deepPurple.withOpacity(0.8),
                          )
                        : const Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        widget.isPasswordType = !widget.isPasswordType;
                      });
                    },
                  )
                : null
            : widget.controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.deepPurple.withOpacity(0.8),
                    ),
                    onPressed: () {
                      setState(() {
                        widget.controller.clear();
                      });
                    },
                  )
                : null,
        labelText: widget.text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(color: Colors.deepPurple),
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.deepPurpleAccent.withOpacity(0.5), width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'Enter your ${widget.text.toLowerCase()}',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onChanged: (text) {
        setState(() {});
      },
      validator: (text) {
        if (text!.isEmpty) {
          return 'Please enter your ${widget.text.toLowerCase()}';
        } else if (widget.text.contains('Email') &&
            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(text)) {
          return 'Please enter a valid email';
        } else if (widget.text.contains('Phone') && text.length < 10) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
      keyboardType: widget.isPasswordType
          ? TextInputType.visiblePassword
          : widget.isPhoneType == true
              ? TextInputType.phone
              : TextInputType.text,
    );
  }
}

Future showBottomSheetPage(BuildContext context, String title) async {
  await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (context) {
        return UpdateProfilePage(
          title: title,
        );
      });
}

class ReuseableTextFormFieldAuth extends StatefulWidget {
  final String text;
  final IconData icon;
  bool isPasswordType;
  final TextEditingController controller;
  ReuseableTextFormFieldAuth({
    Key? key,
    required this.text,
    required this.icon,
    required this.isPasswordType,
    required this.controller,
  }) : super(key: key);

  @override
  State<ReuseableTextFormFieldAuth> createState() =>
      _ReuseableTextFormFieldAuth();
}

class _ReuseableTextFormFieldAuth extends State<ReuseableTextFormFieldAuth> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordType,
      enableSuggestions: !widget.isPasswordType,
      autocorrect: !widget.isPasswordType,
      cursorColor: Colors.deepPurpleAccent,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.red),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
        alignLabelWithHint: true,
        prefixIcon: Icon(
          widget.icon,
          color: Colors.deepPurple.withOpacity(0.8),
        ),
        prefixIconColor: Colors.black,
        suffixIcon: widget.isPasswordType
            ? widget.controller.text.isNotEmpty
                ? IconButton(
                    icon: widget.isPasswordType
                        // ignore: dead_code
                        ? Icon(
                            Icons.visibility_off,
                            color: Colors.deepPurple.withOpacity(0.8),
                          )
                        : const Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        widget.isPasswordType = !widget.isPasswordType;
                      });
                    },
                  )
                : null
            : widget.controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.deepPurple.withOpacity(0.8),
                    ),
                    onPressed: () {
                      setState(() {
                        widget.controller.clear();
                      });
                    },
                  )
                : null,
        labelText: widget.text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(color: Colors.deepPurple),
        fillColor: Colors.white,
        errorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.deepPurpleAccent.withOpacity(0.5), width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: 'Enter your ${widget.text.toLowerCase()}',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.deepPurpleAccent.withOpacity(0.5), width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (text) {
        setState(() {});
      },
      validator: (text) {
        if (text!.isEmpty) {
          return 'Please enter your ${widget.text.toLowerCase()}';
        } else if (widget.text.contains('Email') &&
            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(text)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      keyboardType: widget.isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}

enum UpdateProfileList {
  name,
  email,
  phone,
  password,
}
