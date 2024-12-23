import 'package:camera/camera.dart';

class Camerainit {
  CameraController? _controller;

  CameraController? get controller => _controller;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      throw Exception('No cameras available');
    }
    final firstCam = cameras.first;
    _controller = CameraController(firstCam, ResolutionPreset.high);
    await _controller!.initialize();
  }
}
