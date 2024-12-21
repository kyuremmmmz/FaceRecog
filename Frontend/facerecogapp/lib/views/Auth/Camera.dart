/// CameraScreen.dart
import 'package:camera/camera.dart';
import 'package:facerecogapp/controllers/CameraControllers.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({required this.cameras, Key? key}) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final CameraControllers controller = CameraControllers();
  late Future<void> cameraValue;
  late CameraController _cameraController;
  @override
  void initState() {
    super.initState();
    controller.getCameraControllers(widget.cameras[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    child: CameraPreview(_cameraController),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }
}
