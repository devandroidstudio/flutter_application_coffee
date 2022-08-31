import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReuseableTextFormField extends StatefulWidget {
  final String text;
  final IconData icon;
  bool isPasswordType;

  final TextEditingController controller;
  ReuseableTextFormField(
      {Key? key,
      required this.text,
      required this.icon,
      required this.isPasswordType,
      required this.controller})
      : super(key: key);

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
      maxLength: widget.isPasswordType ? 20 : null,
      maxLengthEnforcement: widget.isPasswordType
          ? MaxLengthEnforcement.truncateAfterCompositionEnds
          : MaxLengthEnforcement.none,
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
                    splashRadius: null,
                    splashColor: Colors.transparent,
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
        hintText: widget.isPasswordType
            ? 'enter your ${widget.text.toLowerCase()}'
            : 'example@gmail.com',
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
        if (text!.isEmpty || text.length < 6) {
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

Widget childBackgroundSignIn(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF701ebd),
          Color(0xFF873bcc),
          Color(0xFFfe4a97),
          Color(0xFFe17763),
          Color(0xFF68998c)
        ],
      ),
    ),
  );
}

Container firebaseUIButton(BuildContext context, String title,
    Color? colorTitle, String? icon, Color color, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.55,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return color.withOpacity(0.5);
            }
            return color;
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Colors.white)),
        ),
      ),
      child: ListTile(
        leading: icon.toString().isEmpty
            ? null
            : Image.asset(
                icon!,
                width: 30,
                height: 30,
              ),
        title: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (rect) => icon.toString().isNotEmpty
              ? const LinearGradient(
                      colors: [Colors.indigoAccent, Colors.pink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      tileMode: TileMode.mirror)
                  .createShader(rect)
              : LinearGradient(
                      colors: [colorTitle!, colorTitle],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      tileMode: TileMode.mirror)
                  .createShader(rect),
          child: Text(
            textAlign:
                icon.toString().isEmpty ? TextAlign.center : TextAlign.left,
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Roboto'),
          ),
        ),
      ),
    ),
  );
}
