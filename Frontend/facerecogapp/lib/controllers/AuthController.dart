import 'package:facerecogapp/models/UserModel.dart';
import 'package:facerecogapp/services/AuthServices/RegistrationSevice.dart';
import 'package:flutter/material.dart';

class Authcontroller with ChangeNotifier {
  final Registrationsevice registration = Registrationsevice();
  Usermodel? _usermodel;
  Usermodel? get user => _usermodel;

  Future<void> registerUser(
    String firstName,
    String lastName,
    String middleInitia,
    String studentID,
    String block,
    String email,
    String password,
  )async{
    try {
      final user = await registration.register(
        firstName, 
        lastName,
        middleInitia, 
        studentID, 
        block, 
        email, 
        password);
      _usermodel = Usermodel.fromJson(user);
      notifyListeners();
    } on Exception catch (e) {
      print('Error registering user: $e');
    }
  }
}
