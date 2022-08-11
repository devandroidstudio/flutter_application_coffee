import 'package:flutter_application_coffee/screens/register/components/body_register.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RegisterPage extends StatelessWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);
  static String routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: BodyRegister(),
      ),
      floatingActionButton: Neumorphic(
        style: const NeumorphicStyle(
            surfaceIntensity: 0.5,
            boxShape: NeumorphicBoxShape.circle(),
            depth: 10,
            intensity: 0.8,
            shape: NeumorphicShape.flat),
        child: NeumorphicButton(
          minDistance: -10,
          onPressed: () {
            showLoginPage();
          },
          style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              color: Colors.white,
              depth: 10,
              intensity: 0.8,
              shape: NeumorphicShape.convex),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
