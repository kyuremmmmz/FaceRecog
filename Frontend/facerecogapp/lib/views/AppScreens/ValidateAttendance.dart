// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';

import 'package:facerecogapp/controllers/AiController.dart';
import 'package:facerecogapp/widgets/Buttons/LoginButton.dart';
import 'package:flutter/material.dart';

class Validateattendance extends StatefulWidget {
  final Uint8List imagePath;
  final Uint8List file2;
  const Validateattendance({
    Key? key,
    required this.imagePath, 
    required this.file2,
  }) : super(key: key);

  @override
  State<Validateattendance> createState() => _ValidateattendanceState();
}

class _ValidateattendanceState extends State<Validateattendance> {
  final AiController controller = AiController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validate Attendance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.memory(widget.imagePath),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: Image.memory(widget.file2),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Loginbutton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: const Color.fromARGB(255, 67, 52, 209)),
              buttonLabel: const Text(
                'Validate My Attendance',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              callback: () async {
                controller.predictImage(widget.imagePath, widget.file2);
              })
          ],
        )
      ),
    );
  }
}
