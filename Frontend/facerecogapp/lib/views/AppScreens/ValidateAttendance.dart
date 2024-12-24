// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Validateattendance extends StatefulWidget {
  final String imagePath;
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
                child: Image.file(File(widget.imagePath)),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: Image.memory(widget.file2),
              )
            ],
          )
          ],
        )
      ),
    );
  }
}
