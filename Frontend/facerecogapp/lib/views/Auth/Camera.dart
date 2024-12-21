import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  Future<void>? cameraValue;

  Future<void> initializeCam() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras.last, ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
    await cameraValue;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializeCam();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cameraValue == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    _cameraController.value.isInitialized) {
                  return CameraPreview(_cameraController);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
    );
  }
}
