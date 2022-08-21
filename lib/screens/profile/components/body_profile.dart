import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/screens/profile/components/item_profile.dart';
import 'package:flutter_application_coffee/screens/profile/detail_profile.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BodyProfile extends StatelessWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      fit: StackFit.passthrough,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                          backgroundImage: NetworkImage(
                              'https://img.icons8.com/cute-clipart/2x/duolingo-logo.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                border:
                                    const NeumorphicBorder(isEnabled: false),
                                boxShape: const NeumorphicBoxShape.circle(),
                                surfaceIntensity: 0.5,
                                depth: 10,
                                intensity: 0.8,
                                shadowLightColor: Colors.black.withOpacity(0.1),
                                lightSource: LightSource.topLeft,
                                shape: NeumorphicShape.flat),
                            child: NeumorphicButton(
                              minDistance: -10,
                              onPressed: () {},
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
                          ? 'Number is empty'
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
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
