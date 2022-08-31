import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/auth_page/main_page.dart';
import 'package:flutter_application_coffee/model/drawer_item.dart';
import 'package:flutter_application_coffee/repo/list_drawer_item.dart';
import 'package:flutter_application_coffee/screens/home/components/get_screens_home.dart';
import 'package:flutter_application_coffee/screens/home/components/menu_home.dart';
import 'package:flutter_application_coffee/view_models/login-register/login_register.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

final ZoomDrawerController z = ZoomDrawerController();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DrawerItem currentItem = DrawerListItem.home;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: z,
      borderRadius: 24,
      style: DrawerStyle.defaultStyle,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.5,
      duration: const Duration(milliseconds: 500),
      angle: 0.0,
      mainScreenAbsorbPointer: false,
      clipMainScreen: true,
      drawerShadowsBackgroundColor: Colors.white,
      menuScreenTapClose: true,
      // area of the screen where the drawer can be closed
      closeDragSensitivity: 500,
      // if true, the main screen will be shrinked when the drawer is open
      shrinkMainScreen: false,
      overlayBlur: 0.0,
      overlayBlend: BlendMode.overlay,
      menuScreenOverlayColor: Colors.white,
      closeCurve: Curves.easeInOut,
      mainScreenTapClose: true,
      androidCloseOnBackTap: true,
      menuBackgroundColor: Colors.indigoAccent,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          spreadRadius: 5,
        ),
      ],
      mainScreen: getScreen(currentItem, z),
      menuScreen: MenuPage(
        curreentItem: currentItem,
        onItemTap: (DrawerItem item) {
          if (item == DrawerListItem.logout) {
            setState(() {
              signOut();
              Navigator.pushReplacementNamed(context, MainPage.routeName);
            });
          }

          setState(() {
            currentItem = item;
          });
          z.close!();
        },
      ),
    );
  }
}
