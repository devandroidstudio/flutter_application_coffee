import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestAPI extends StatefulWidget {
  const TestAPI({Key? key}) : super(key: key);

  @override
  State<TestAPI> createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {
  Map<String, dynamic> datas = {};
  Future<dynamic> texttesting(String uid) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) => value.data()!['phone'])
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FirebaseAuth.instance.currentUser!.uid),
      ),
    );
  }
}
