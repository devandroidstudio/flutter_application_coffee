import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/model/drawer_item.dart';
import 'package:flutter_application_coffee/repo/list_drawer_item.dart';
import 'package:flutter_application_coffee/screens/home/list_item.dart';
import 'package:flutter_application_coffee/screens/profile/profile.dart';
import 'package:flutter_application_coffee/setting/setting.dart';
import 'package:flutter_zoom_drawer/config.dart';

Widget getScreen(DrawerItem currentItem, ZoomDrawerController z) {
  if (currentItem == DrawerListItem.home) {
    return CoffeeConceptList(z);
  } else if (currentItem == DrawerListItem.profile) {
    return ProfilePage(z);
  } else if (currentItem == DrawerListItem.settings) {
    return SettingPage(z);
  } else {
    return CoffeeConceptList(z);
  }
}
