import 'package:tflite_flutter/tflite_flutter.dart';

class MLService {
  Future<void> mldata() async {
    final interpreter = await Interpreter.fromAsset('assets/your_model.tflite');
    
  }
}
