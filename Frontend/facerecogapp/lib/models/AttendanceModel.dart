// ignore_for_file: public_member_api_docs, sort_constructors_first
class AttendanceModel {
  final String? studentID;
  final String? date;
  final String? present;
  final String? subjectCodetAttended;
  AttendanceModel({
    this.studentID,
    this.date,
    this.present,
    this.subjectCodetAttended,
  });
  

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      studentID: json['studentID'],
      date: json['date'],
      present: json['present'],
      subjectCodetAttended: json['subjectCodeAttended'],
    );
  }
}
