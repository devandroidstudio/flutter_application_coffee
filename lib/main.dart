import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/auth_page/main_page.dart';
import 'package:flutter_application_coffee/helper/routes.dart';
import 'package:flutter_application_coffee/view_models/login-register/coffee_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => CoffeeProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MainPage.routeName,
      routes: routes,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
