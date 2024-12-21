// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class Usermodel {
  final String firstName;
  final String lastName;
  final String middleInitial;
  final String block;
  final String email;
  final String studentID;
  final String password;

  Usermodel({
    required this.firstName,
    required this.lastName,
    required this.middleInitial,
    required this.block,
    required this.email,
    required this.studentID,
    required this.password,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      middleInitial: json['middleInitial'].toString(),
      block: json['block'].toString(),
      email: json['email'].toString(),
      studentID: json['studentID'].toString(),
      password: json['password'].toString(),
    );
  }
}
