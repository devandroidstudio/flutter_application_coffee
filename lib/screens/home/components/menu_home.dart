import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/model/drawer_item.dart';
import 'package:flutter_application_coffee/repo/list_drawer_item.dart';
import 'package:lottie/lottie.dart';

class MenuPage extends StatelessWidget {
  final DrawerItem curreentItem;
  final ValueChanged<DrawerItem> onItemTap;
  const MenuPage(
      {Key? key, required this.curreentItem, required this.onItemTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              DrawerHeader(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.only(bottom: 5),
                curve: Curves.easeIn,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Lottie.asset(
                        'assets/images/welcome.json',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: DrawerListItem.screens.map((e) {
                    return ListTileTheme(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      style: ListTileStyle.drawer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      selectedColor: Colors.white,
                      child: ListTile(
                        horizontalTitleGap: 10,
                        selectedTileColor: Colors.black26,
                        selected: e == curreentItem,
                        minLeadingWidth: 40,
                        title: Text(e.title),
                        leading: Icon(e.icon),
                        onTap: () {
                          onItemTap(e);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          )),
    );
  }
}
