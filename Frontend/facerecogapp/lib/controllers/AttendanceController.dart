import 'package:facerecogapp/models/AttendanceModel.dart';
import 'package:facerecogapp/services/AppServices/AttendanceService.dart';
import 'package:flutter/material.dart';

class AttendanceController with ChangeNotifier {
  AttendanceModel? _attendanceModel;
  AttendanceModel? get attendance => _attendanceModel;
  final attendanceService = AttendanceService();
  Future<void> attend(String studentID, String date,
      String present, String subjectCodeAttended) async{
        try {
          final student = await attendanceService.attendance(studentID, date, present, subjectCodeAttended);
          _attendanceModel = AttendanceModel.fromJson(student);
          notifyListeners();
        } catch (e) {
          
        }
      }
}