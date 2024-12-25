// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validate Attendance'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildImageCard(widget.imagePath, 'Captured Image'),
                  _buildImageCard(widget.file2, 'Reference Image'),
                ],
              ),
              const SizedBox(height: 30),
              Loginbutton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 67, 52, 209),
                ),
                buttonLabel: const Text(
                  'Validate My Attendance',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                callback: () async {
                  await controller.predictImage(
                    widget.imagePath,
                    widget.file2,
                  );
                  setState(() {
                    message = 'test';
                  });
                },
              ),
              const SizedBox(height: 30),
              _buildResultCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(Uint8List imageData, String title) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              imageData,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildResultCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Validation Result',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message ?? 'Your validation result will appear here.',
              style: TextStyle(
                fontSize: 16,
                color: message == null ? Colors.grey : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
