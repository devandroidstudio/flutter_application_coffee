import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/profile/components/item_profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

const double fontSize = 15.0;
Future updateUser(
    BuildContext context,
    String user,
    String title,
    TextEditingController emailController,
    TextEditingController passwordController) async {
  final formKey = GlobalKey<FormState>();
  if (title.contains('Email')) {
    await FirebaseAuth.instance.currentUser!.updateEmail(user).then((value) {
      if (FirebaseAuth.instance.currentUser!.email == user) {
        Fluttertoast.showToast(
            msg: 'Update is failure. Email is exist',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: fontSize);
      } else {
        Fluttertoast.showToast(
            msg: "Update email success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            webShowClose: true,
            fontSize: fontSize);
      }

      Navigator.of(context).pop();
    }).catchError((e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Warning'),
          content: Form(
            key: formKey,
            child: textFormFielAuth(
                emailController: emailController,
                passwordController: passwordController,
                error: e.toString().split(']')[1]),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ButtonAuth(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController),
          ],
        ),
      );
    });
  } else if (title.contains('User Name')) {
    await FirebaseAuth.instance.currentUser!
        .updateDisplayName(user)
        .then((value) {
      if (FirebaseAuth.instance.currentUser!.displayName == user) {
        Fluttertoast.showToast(
            msg: 'Update is failure. User name is exist',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: fontSize);
      } else {
        Fluttertoast.showToast(
            msg: "Update user name success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            webShowClose: true,
            fontSize: fontSize);
      }
      Navigator.of(context).pop();
    }).catchError((e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Warning'),
          content: Form(
            key: formKey,
            child: textFormFielAuth(
                emailController: emailController,
                passwordController: passwordController,
                error: e.toString().split(']')[1]),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ButtonAuth(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController),
          ],
        ),
      );
    });
  } else if (title.contains('Password')) {
    await FirebaseAuth.instance.currentUser!.updatePassword(user).then((value) {
      Fluttertoast.showToast(
          msg: "Update password success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          webShowClose: true,
          fontSize: fontSize);
      Navigator.of(context).pop();
    }).catchError((e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Warning'),
          content: Form(
            key: formKey,
            child: textFormFielAuth(
                emailController: emailController,
                passwordController: passwordController,
                error: e.toString().split(']')[1]),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ButtonAuth(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController),
          ],
        ),
      );
    });
  }
}

class ButtonAuth extends StatelessWidget {
  const ButtonAuth({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('OK'),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          reupdate(context, emailController.text, passwordController.text);
        }
      },
    );
  }
}

class textFormFielAuth extends StatelessWidget {
  const textFormFielAuth({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.error,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(error),
        const SizedBox(height: 10),
        ReuseableTextFormFieldAuth(
          controller: emailController,
          icon: Icons.email,
          text: 'Email',
          isPasswordType: false,
        ),
        const SizedBox(height: 10),
        ReuseableTextFormFieldAuth(
          controller: passwordController,
          icon: Icons.lock,
          text: 'Password',
          isPasswordType: true,
        ),
      ],
    );
  }
}

Future reupdate(BuildContext context, String email, String password) async {
  await FirebaseAuth.instance.currentUser!
      .reauthenticateWithCredential(
          EmailAuthProvider.credential(email: email, password: password))
      .whenComplete(() {
    Navigator.of(context).pop();
  });
}

class UpdateUser extends ChangeNotifier {
  late String _imageUser;
  final storageReference = FirebaseStorage.instance.ref('images');
  late XFile imageFile;
  final imagePicker = ImagePicker();
  final user = FirebaseAuth.instance.currentUser;

  void imageFileUpdate(XFile value) {
    imageFile = value;
    notifyListeners();
  }

  uploadImage() async {
    // PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
        if (value != null) {
          imageFileUpdate(value);
        } else {
          Fluttertoast.showToast(
              msg: 'Please select image',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: fontSize);
        }
      });
      var file = File(imageFile.path);

      if (imageFile.path.isNotEmpty) {
        storageReference.child(user!.uid).putFile(file).then((value) {
          value.ref.getDownloadURL().then((value) {
            _imageUser = value;
            notifyListeners();
          }).whenComplete(() {
            FirebaseAuth.instance.currentUser!.updatePhotoURL(_imageUser);
          }).onError((error, stackTrace) {
            Fluttertoast.showToast(
                msg: 'Error: $error',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: fontSize);
          });
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }
}
