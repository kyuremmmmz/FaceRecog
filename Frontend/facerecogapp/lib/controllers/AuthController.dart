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
    String imagePath
  ) async {
    try {
      final user = await registration.register(
          firstName, lastName, middleInitia, studentID, block, email, password, imagePath);
      _usermodel = Usermodel.fromJson(user);
      print("User email: ${_usermodel?.email}");
      notifyListeners();
    } on Exception catch (e) {
      print('Error registering user: $e');
    }
  }

  Future<void> loginUser(BuildContext context,String email, String password) async {
  try {
    final user = await registration.loginUser(email, password);
    
    if (user['error'] == true || user['userResponse'] == "Invalid password") {
      print('Login failed: ${user['message']}');
      notifyListeners();
      return;
    }
    if (user['email'] != null) {
      _usermodel = Usermodel.fromJson(user);
      print('User email: ${_usermodel?.email}');
      Navigator.pushNamed(context, '/home');
      notifyListeners();
      return;
    } else {
      return;
    }
  } catch (e) {
    print('Error logging in user: $e');
  }
}


}
