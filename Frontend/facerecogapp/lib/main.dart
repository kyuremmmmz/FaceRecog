import 'package:facerecogapp/controllers/AuthController.dart';
import 'package:facerecogapp/views/AppScreens/Welcome.dart';
import 'package:facerecogapp/views/Auth/LandingScreen.dart';
import 'package:facerecogapp/views/Auth/Login.dart';
import 'package:facerecogapp/views/Auth/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Authcontroller(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Landingscreen(),
        initialRoute: '/landingScreen',
        routes: {
          '/landingScreen': (context) => const Landingscreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => Welcome(),
        },
      ),
    );
  }
}


