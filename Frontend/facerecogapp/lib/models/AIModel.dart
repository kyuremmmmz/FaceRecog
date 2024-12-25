// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

class Aimodel {
  final String message;
  final String distance;

  Aimodel({
    required this.message,
    required this.distance,
  });
  
  factory Aimodel.fromJson(Map<String, dynamic> json) {
    return Aimodel(
        message: json['message'].toString(),
        distance: json['distance'].toString(),
    );
  }
}
