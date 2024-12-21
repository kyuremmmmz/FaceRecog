// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class Usermodel {
  final int id;
  final String firstName;
  final String lastName;
  final String middleInitial;
  final String block;
  final String yearLevel;
  final String email;
  final String studentID;
  final String password;

  Usermodel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleInitial,
    required this.block,
    required this.yearLevel,
    required this.email,
    required this.studentID,
    required this.password,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      middleInitial: json['middle_initial'],
      block: json['block'],
      yearLevel: json['year_level'],
      email: json['email'],
      studentID: json['student_id'],
      password: json['password'],
    );
  }
}
