import 'package:facerecogapp/controllers/AuthController.dart';
import 'package:facerecogapp/views/AppScreens/Welcome.dart';
import 'package:facerecogapp/views/Auth/Login.dart';
import 'package:facerecogapp/views/WrapperScreens/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loginwrapper extends StatefulWidget {
  const Loginwrapper({super.key});

  @override
  State<Loginwrapper> createState() => _LoginwrapperState();
}

class _LoginwrapperState extends State<Loginwrapper> {
  @override
  Widget build(BuildContext context) {
    final result = Provider.of<Authcontroller>(context).user;
    if (result?.email != null) {
      return const Welcome();
    } else {
      return const LoginScreen();
    }
  }
}