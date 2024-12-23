// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      appBar: AppBar(
        title: const Text('Image Preview'),
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Image.file(File(widget.imagePath)),
          ),
          SizedBox(
              height: 10,
              child: Loginbutton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 67, 52, 209),
                      fixedSize: Size(350, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  buttonLabel: const Text(
                    'Sign up as Student',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  callback: () async{
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
                        'data:image/jpeg;base64,$convertTobase64'
                        );
                  }))
        ],
      )),
    );
  }
}
