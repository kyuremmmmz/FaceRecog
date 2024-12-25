// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camera/camera.dart';
import 'package:facerecogapp/controllers/CameraInit.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String middleInitial;
  final String block;
  final String email;
  final String studentID;
  final String password;
  const CameraScreen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.middleInitial,
    required this.block,
    required this.email,
    required this.studentID,
    required this.password,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await init.takePicture(
            context, 
            widget.firstName, 
            widget.lastName, 
            widget.middleInitial, 
            widget.block,
            widget.email,
            widget.studentID,
            widget.password,
            );
        },
        tooltip: 'Take Picture',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
