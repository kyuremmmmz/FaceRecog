import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:facerecogapp/controllers/CameraInit.dart';
import 'package:flutter/material.dart';

class Attendancecamera extends StatefulWidget {
  final Uint8List file1;
  const Attendancecamera({super.key, required this.file1});

  @override
  State<Attendancecamera> createState() => _AttendancecameraState();
}

class _AttendancecameraState extends State<Attendancecamera> {
  final Camerainit init = Camerainit();
  Future<void>? _cameraInitialization;
  bool isFaceAligned = false; // Track if face is aligned within the frame
  bool isStreaming = false; // Prevent multiple streams

  @override
  void initState() {
    super.initState();
    _cameraInitialization = init.initializeCamera();
  }

  @override
  void dispose() {
    if (init.controller != null && isStreaming) {
      init.controller!.stopImageStream();
    }
    init.controller?.dispose();
    super.dispose();
  }

  void startImageStream() {
    if (!isStreaming && init.controller != null) {
      isStreaming = true;
      init.controller!.startImageStream((CameraImage image) {
        analyzeImage(image);
      });
    }
  }

  void analyzeImage(CameraImage image) {
    int totalBrightness = 0;
    int pixelCount = 0;

    for (Plane plane in image.planes) {
      for (int i = 0; i < plane.bytes.length; i += plane.bytesPerPixel ?? 1) {
        totalBrightness += plane.bytes[i];
        pixelCount++;
      }
    }

    double averageBrightness = totalBrightness / pixelCount;

    setState(() {
      isFaceAligned = averageBrightness > 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _cameraInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to initialize camera: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              init.controller != null &&
              init.controller!.value.isInitialized) {
            startImageStream();

            return Stack(
              children: [
                CameraPreview(init.controller!),
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: isFaceAligned
                          ? Colors.transparent
                          : Colors.red.withOpacity(0.3),
                      border: Border.all(
                        color: isFaceAligned ? Colors.green : Colors.red,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Camera not available'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          init.takePictureValidation(context, widget.file1);
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
