// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

class Aimodel {
  final String file1;
  final String file2;

  Aimodel({
    required this.file1,
    required this.file2,
  });
  
  factory Aimodel.fromJson(Map<String, dynamic> json) {
    return Aimodel(
        file1: json['file1'].toString(),
        file2: json['file2'].toString(),
    );
  }
}
