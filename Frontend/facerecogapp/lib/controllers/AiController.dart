import 'package:facerecogapp/models/AIModel.dart';

class AiController {
  Aimodel? _aimodel;
  Aimodel? get aiModel => _aimodel;
  Future<void> predictImage(num distance, String message) async {
    try {
      _aimodel = Aimodel(distance: distance, message: message);
    } on Exception catch (e) {
      print('Error predicting image: $e');
    }
  }
}
