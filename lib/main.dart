import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_coffee/auth_page/main_page.dart';
import 'package:flutter_application_coffee/helper/routes.dart';
import 'package:flutter_application_coffee/model/product_cart.dart';
import 'package:flutter_application_coffee/screens/onBoarding/onBoarding.dart';
import 'package:flutter_application_coffee/view_models/login-register/cart_provider.dart';
import 'package:flutter_application_coffee/view_models/login-register/coffee_provider.dart';
import 'package:flutter_application_coffee/view_models/main_provider/account_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(CoffeeItemsAdapter());
  Hive.registerAdapter(ProductsAdapter());
  await Hive.openBox<CoffeeItems>('listProductOfCart');
  await Hive.openBox<String>('isFirstLogin2');
  // await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => CoffeeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => UpdateUser(),
      ),
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
      )
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showSemanticsDebugger: true,
      // showPerformanceOverlay: true,
      initialRoute: MyApp2.routeName,
      routes: routes,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyApp2 extends StatefulWidget {
  const MyApp2({super.key});
  static String routeName = '/root';

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    // final box = Hive.box<String>('isFirstLogin2');
    // if (box.isNotEmpty) {
    //   return MainPage();
    // } else {
    //   return OnBoardingPage();
    // }
    // return ValueListenableBuilder<Box<String>>(
    //   valueListenable: Hive.box<String>('isFirstLogin2').listenable(),
    //   builder: (context, value, child) {

    //     if (value.isNotEmpty) {
    //       return const MainPage();
    //     } else {
    //       return const OnBoardingPage();
    //     }
    //   },
    // );
    return FutureBuilder(
      initialData: 'asd',
      future: Hive.openBox<String>('isFirstLogin2'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return const MainPage();
          } else {
            const OnBoardingPage();
          }
        }
        return const Scaffold();
      },
    );
  }
}
