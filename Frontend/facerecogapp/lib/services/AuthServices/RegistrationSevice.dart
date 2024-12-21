import 'dart:convert';
import 'package:http/http.dart' as http;

class Registrationsevice {
  final baseUrl = 'http://10.0.2.2:3000';

  Future<Map<String, dynamic>> register(
      String firstName,
      String lastName,
      String middleInitia,
      String studentID,
      String block,
      String email,
      String password) async {
    final url = await http.post(Uri.parse('$baseUrl/auth/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'firstName': firstName,
          'lastName': lastName,
          'middleInitial': middleInitia,
          'studentID': studentID,
          'block': block,
          'email': email,
          'password': password
        }));
    if (url.statusCode == 201) {
      return json.decode(url.body);
    }else{
      throw Exception('Failed to register user: $url');
    }
  }
}
