import 'dart:convert';
import 'dart:io';

import 'package:facerecogapp/controllers/AuthController.dart';
import 'package:facerecogapp/widgets/Buttons/LoginButton.dart';
import 'package:flutter/material.dart';

class Imagescreen extends StatefulWidget {
  final String imagePath;
  final String firstName;
  final String lastName;
  final String middleInitial;
  final String block;
  final String email;
  final String studentID;
  final String password;
  const Imagescreen({
    Key? key,
    required this.imagePath,
    required this.firstName,
    required this.lastName,
    required this.middleInitial,
    required this.block,
    required this.email,
    required this.studentID,
    required this.password,
  }) : super(key: key);

  @override
  State<Imagescreen> createState() => _ImagescreenState();
}

class _ImagescreenState extends State<Imagescreen> {
  final Authcontroller controller = Authcontroller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Image Preview',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.file(
                File(widget.imagePath),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Confirm your details below and sign up",
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Loginbutton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 67, 52, 209),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              buttonLabel: const Text(
                'Sign up as Student',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              callback: () async {
                final bytes = await File(widget.imagePath).readAsBytes();
                final convertTobase64 = base64Encode(bytes);
                controller.registerUser(
                  widget.firstName,
                  widget.lastName,
                  widget.middleInitial,
                  widget.studentID,
                  widget.block,
                  widget.email,
                  widget.password,
                  'data:image/jpeg;base64,$convertTobase64',
                );
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
