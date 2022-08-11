import 'package:flutter/material.dart';

class ReuseableTextFormField extends StatefulWidget {
  final String text;
  final IconData icon;
  bool isPasswordType;
  bool? isPhoneType;
  final TextEditingController controller;
  ReuseableTextFormField({
    Key? key,
    required this.text,
    required this.icon,
    required this.isPasswordType,
    required this.controller,
    this.isPhoneType,
  }) : super(key: key);

  @override
  State<ReuseableTextFormField> createState() => _ReuseableTextFormFieldState();
}

class _ReuseableTextFormFieldState extends State<ReuseableTextFormField> {
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
        if (text!.isEmpty || text.length < 5) {
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
          : widget.isPhoneType == true
              ? TextInputType.phone
              : TextInputType.text,
    );
  }
}
