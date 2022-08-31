import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/profile/components/item_profile.dart';
import 'package:flutter_application_coffee/view_models/main_provider/account_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageAccout(
                        image: snapshot.data!.photoURL.toString(),
                      ),
                      Text(
                        '${snapshot.data!.displayName}',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${snapshot.data!.email}',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: 20),
                      ReuseEmailAuthButton(
                          title: 'Email Authentication',
                          subtitle:
                              'Protect your customers and subscribers. It may not be your direct responsibility to stop email spoofing from fooling people',
                          onTap: () async {
                            await FirebaseAuth.instance.currentUser!
                                .sendEmailVerification()
                                .then((value) {
                              Fluttertoast.showToast(
                                  msg: "Please check your email",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.greenAccent,
                                  textColor: Colors.white,
                                  webShowClose: true,
                                  fontSize: fontSize);
                            }).catchError((e) {
                              Fluttertoast.showToast(
                                  msg: e.toString().split(']')[1],
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.redAccent,
                                  textColor: Colors.white,
                                  webShowClose: true,
                                  fontSize: fontSize);
                            });
                          }),
                      const SizedBox(height: 20),
                      ReuseButtonProfile(
                        onTap: () {
                          showBottomSheetPage(context, 'Email');
                        },
                        title: 'Email',
                        subtitle: snapshot.data!.email.toString(),
                        icon: Icons.email,
                      ),
                      ReuseButtonProfile(
                        onTap: () {
                          showBottomSheetPage(context, 'User Name');
                        },
                        title: 'User Name',
                        subtitle: snapshot.data!.displayName.toString(),
                        icon: Icons.person,
                      ),
                      ReuseButtonProfile(
                        onTap: () {
                          showBottomSheetPage(context, 'Phone Number');
                        },
                        title: 'Phone Number',
                        subtitle: snapshot.data!.phoneNumber.toString().isEmpty
                            ? 'Not Phone Number'
                            : snapshot.data!.phoneNumber.toString(),
                        icon: Icons.phone,
                      ),
                      ReuseButtonProfile(
                        onTap: () {
                          showBottomSheetPage(context, 'Password');
                        },
                        title: 'Password',
                        subtitle: snapshot.data!.email.toString(),
                        icon: Icons.lock,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class ImageAccout extends StatefulWidget {
  final String image;
  const ImageAccout({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<ImageAccout> createState() => _ImageAccoutState();
}

class _ImageAccoutState extends State<ImageAccout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateUser>(
      builder: (context, snapshot, child) {
        return Stack(
          fit: StackFit.passthrough,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              foregroundImage: FirebaseAuth.instance.currentUser!.photoURL !=
                      null
                  ? NetworkImage(widget.image)
                  : const NetworkImage(
                      'https://img.icons8.com/pastel-glyph/2x/person-male--v3.png'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Neumorphic(
                style: NeumorphicStyle(
                    border: const NeumorphicBorder(isEnabled: false),
                    boxShape: const NeumorphicBoxShape.circle(),
                    surfaceIntensity: 0.5,
                    depth: 10,
                    intensity: 0.8,
                    shadowLightColor: Colors.black.withOpacity(0.1),
                    lightSource: LightSource.topLeft,
                    shape: NeumorphicShape.flat),
                child: NeumorphicButton(
                  minDistance: -10,
                  onPressed: () {
                    snapshot.uploadImage();
                  },
                  style: const NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                      color: Colors.white,
                      depth: 10,
                      intensity: 0.8,
                      shape: NeumorphicShape.convex),
                  child: const Icon(Icons.edit),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
