import 'package:facerecogapp/models/UserModel.dart';
import 'package:facerecogapp/services/AuthServices/RegistrationSevice.dart';
import 'package:flutter/material.dart';

class Authcontroller with ChangeNotifier {
  final Registrationsevice registration = Registrationsevice();
  Usermodel? _usermodel;
  Usermodel? get user => _usermodel;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  String? user2;
  Future<void> registerUser(
      String firstName,
      String lastName,
      String middleInitia,
      String studentID,
      String block,
      String email,
      String password,
      String imagePath) async {
    try {
      final user = await registration.register(firstName, lastName,
          middleInitia, studentID, block, email, password, imagePath);
      _usermodel = Usermodel.fromJson(user);
      print("User email: $email");
      notifyListeners();
    } on Exception catch (e) {
      print('Error registering user: $e');
    }
  }

  Future<void> loginUser(BuildContext context, String email, String password) async {
    try {
      final user = await registration.loginUser(email, password);
      if (user['error'] == true || user['userResponse'] == "Invalid password") {
        print('Login failed: ${user['message']}');
        notifyListeners();
        return;
      }
      if (user['email'] != null) {
        _isLoggedIn = true;
        _usermodel = Usermodel.fromJson(user);
        print('User email: ${_usermodel?.email}');
        print(user['body']);
        notifyListeners();
        return;
      } else {
        _isLoggedIn = false;
        return;
      }
    } catch (e) {
      print('Error logging in user: $e');
    }
  }

  Future<void> logoutUser(BuildContext context) async {
    try {
      _isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      print('Error logging out user: $e');
    }
  }
}
