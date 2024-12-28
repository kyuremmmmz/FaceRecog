import 'package:facerecogapp/controllers/AiController.dart';
import 'package:facerecogapp/controllers/AttendanceController.dart';
import 'package:facerecogapp/controllers/AuthController.dart';
import 'package:facerecogapp/views/AppScreens/Profiles.dart';
import 'package:facerecogapp/views/AppScreens/Welcome.dart';
import 'package:facerecogapp/views/AttendanceReport/AttendanceReports.dart';
import 'package:facerecogapp/views/Auth/AuthWrapper.dart';
import 'package:facerecogapp/views/Auth/LandingScreen.dart';
import 'package:facerecogapp/views/Auth/Login.dart';
import 'package:facerecogapp/views/Auth/SignUp.dart';
import 'package:facerecogapp/views/WrapperScreens/LoginWrapper.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authcontroller()),
        ChangeNotifierProvider(create: (_) => AiController()),
        ChangeNotifierProvider(create: (_)=> AttendanceController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Authwrapper(),
        routes: {
          '/landingScreen': (context) => const Landingscreen(),
          '/login': (context) => const Loginwrapper(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => Welcome(),
          '/profile': (context) => Profiles(),
          '/reports': (context) => Attendancereports()
        },
      ),
    );
  }
}
