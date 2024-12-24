import 'dart:ffi';
import 'dart:typed_data';

import 'package:facerecogapp/models/AIModel.dart';
import 'package:facerecogapp/models/UserModel.dart';
import 'package:facerecogapp/services/ML/MLService.dart';
import 'package:flutter/material.dart';

class AiController with ChangeNotifier {
  Aimodel? _aimodel;
  Usermodel? _usermodel;
  Usermodel? get user => _usermodel;
  Aimodel? get aiModel => _aimodel;
  final MLService mlService = MLService();
  Future<void> predictImage(Uint8List file1, Uint8List file2) async {
    try {
      final machine = await mlService.predictImage(file1, file2);
      _aimodel = Aimodel.fromJson(machine);
      notifyListeners();
      return;
    } on Exception catch (e) {
      print('Error predicting image: $e');
    }
  }

  Future<void> getImage(String studentID) async {
    try {
      final image = await mlService.getImage(studentID);
      _usermodel = Usermodel.fromID(image);
      print('Image: ${_usermodel?.imagePath}');
      notifyListeners();
      return;
    } on Exception catch (e) {
      print('Error getting image: $e');
    }
  }
}
