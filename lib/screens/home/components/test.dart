import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/auth_page/main_page.dart';
import 'package:hive/hive.dart';

// class TestAPI extends StatefulWidget {
//   const TestAPI({Key? key}) : super(key: key);

//   @override
//   State<TestAPI> createState() => _TestAPIState();
// }

// class _TestAPIState extends State<TestAPI> {
//   Map<String, dynamic> datas = {};
//   Future<dynamic> texttesting(String uid) async {
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .get()
//         .then((value) => value.data()!['phone'])
//         .toString();
//   }

//   static String routeName = '/';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(FirebaseAuth.instance.currentUser!.uid),
//       ),
//     );
//   }
// }

class TestAPI extends StatefulWidget {
  const TestAPI({super.key});
  static String routeName = '/test';

  @override
  State<TestAPI> createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('isFirstLogin');
    return Scaffold(
      body: Center(
          child: Container(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('click'),
              onPressed: () {
                box.delete('bac');
              },
            ),
            ElevatedButton(
              child: Text('addd'),
              onPressed: () {
                box.put('abc', '1232');
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ));
                },
                child: Text('Main'))
          ],
        ),
      )),
    );
  }
}
