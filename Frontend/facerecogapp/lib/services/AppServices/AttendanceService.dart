import 'dart:convert';

import 'package:http/http.dart' as http;

class AttendanceService {
  final baseUrl = "http://192.168.100.7:3000";

  Future<Map<String, dynamic>> attendance(String studentID, String date,
      String present, String subjectCodeAttended) async {
    try {
      final url = Uri.parse('$baseUrl/attend');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode({
            "studentId": studentID,
            "date": date,
            "present": present,
            "subjectCodeAttended": subjectCodeAttended,
          }));
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = await json.decode(response.body);
        return{
          "success": true,
          "data": decodedResponse,
          "message": decodedResponse['message']
        };
      } else {
        return{
          "success": false,
          "error": "Error connecting to the server",
        };
      }
    } catch (e) {
      print(e);
      return {
        "success": false,
        "error": "Error connecting to the server",
      };
    }
  }
}
