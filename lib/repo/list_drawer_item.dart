import 'package:flutter/cupertino.dart';
import 'package:flutter_application_coffee/model/drawer_item.dart';

class DrawerListItem {
  static final home = DrawerItem(
    title: 'Home',
    icon: CupertinoIcons.home,
  );

  static final profile =
      DrawerItem(title: 'Profile', icon: CupertinoIcons.profile_circled);
  static final contact = DrawerItem(
    title: 'Contact',
    icon: CupertinoIcons.phone,
  );
  static final settings =
      DrawerItem(title: 'Settings', icon: CupertinoIcons.settings);
  static final logout =
      DrawerItem(title: 'Logout', icon: CupertinoIcons.square_arrow_right);

  static final List<DrawerItem> screens = [
    home,
    profile,
    settings,
    logout,
  ];
}
