import 'package:facerecogapp/controllers/AuthController.dart';
import 'package:facerecogapp/views/AppScreens/Welcome.dart';
import 'package:facerecogapp/views/Auth/LandingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authwrapper extends StatefulWidget {
  const Authwrapper({super.key});

  @override
  State<Authwrapper> createState() => _AuthwrapperState();
}

class _AuthwrapperState extends State<Authwrapper> {
  final authController = Authcontroller();

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<Authcontroller>(context).user;
    if (result?.email != null) {
      return const Welcome();
    } else {
      return const Landingscreen();
    }
  }
}
