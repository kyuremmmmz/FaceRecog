// ignore_for_file: public_member_api_docs, sort_constructors_first

class Usermodel {
  final String? firstName;
  final String? lastName;
  final String? middleInitial;
  final String? block;
  final String? email;
  final String? studentID;
  final String? password;
  final String? imagePath;
  Usermodel({
    this.firstName,
    this.lastName,
    this.middleInitial,
    this.block,
    this.email,
    this.studentID,
    this.password,
    this.imagePath,
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
      imagePath: json['imagePath'].toString(),
    );
  }

  factory Usermodel.fromAuthJson(Map<String, dynamic> json) {
    return Usermodel(
        email: json['email']?.toString(),
        firstName: json['firstName'].toString());
  }

  factory Usermodel.fromID(Map<String, dynamic> json) {
    return Usermodel(
      studentID: json['studentID']?.toString(),
      imagePath: json['imagePath']?.toString() ?? 'default_image_path',
    );
  }
}
