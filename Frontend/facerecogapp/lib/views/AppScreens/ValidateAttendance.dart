import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:facerecogapp/controllers/AiController.dart';
import 'package:facerecogapp/controllers/AttendanceController.dart';
import 'package:facerecogapp/widgets/Buttons/LoginButton.dart';
import 'package:facerecogapp/widgets/Modals/BottomModal.dart';

class Validateattendance extends StatefulWidget {
  final Uint8List imagePath;
  final Uint8List file2;

  const Validateattendance({
    super.key,
    required this.imagePath,
    required this.file2,
  });

  @override
  State<Validateattendance> createState() => _ValidateattendanceState();
}

class _ValidateattendanceState extends State<Validateattendance> {
  final AiController controller = AiController();
  bool _isValidating = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validate Attendance'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImageCard(widget.imagePath),
                const SizedBox(width: 20),
                _buildImageCard(widget.file2),
              ],
            ),
            const SizedBox(height: 30),
            _isValidating
                ? const CircularProgressIndicator(
                    color: Color.fromARGB(255, 67, 52, 209),
                  )
                : Loginbutton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(350, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color.fromARGB(255, 67, 52, 209),
                      elevation: 5,
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
                      setState(() {
                        _isValidating = true;
                      });
                      final result = await controller.predictImage(
                          widget.imagePath, widget.file2);
                      setState(() {
                        _isValidating = false;
                      });

                      if (result['message'] == 'Faces match!') {
                        await BottomModal().modal(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Faces do not match!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(Uint8List imageData) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.memory(
          imageData,
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.3,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
