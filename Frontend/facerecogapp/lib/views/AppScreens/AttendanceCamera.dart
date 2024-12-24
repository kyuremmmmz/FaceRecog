import 'package:camera/camera.dart';
import 'package:facerecogapp/controllers/CameraInit.dart';
import 'package:flutter/material.dart';

class Attendancecamera extends StatefulWidget {
  const Attendancecamera({super.key});

  @override
  State<Attendancecamera> createState() => _AttendancecameraState();
}

class _AttendancecameraState extends State<Attendancecamera> {
  final Camerainit init = Camerainit();
  Future<void>? _cameraInitialization;

  @override
  void initState() {
    super.initState();
    _cameraInitialization = init.initializeCamera();
  }

  @override
  void dispose() {
    init.controller?.dispose();
    super.dispose();
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
            return Container(
                child: CameraPreview(
              init.controller!,
            ));
          } else {
            return const Center(
              child: Text('Camera not available'),
            );
          }
        },
      ),
    );
  }
}
