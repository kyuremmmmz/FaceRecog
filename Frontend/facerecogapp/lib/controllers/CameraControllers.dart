import 'package:camera/camera.dart';

class CameraControllers {
  
  Future <void> getCameraControllers(CameraDescription camera) async{
    late CameraController _cameraController;
    late Future<void> cameraValue;
    _cameraController = CameraController(camera, ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }
}