import 'package:facerecogapp/controllers/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Authcontroller>(context);
    print(provider.user?.email);
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome ${provider.user?.email} to Face Recognition App',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
