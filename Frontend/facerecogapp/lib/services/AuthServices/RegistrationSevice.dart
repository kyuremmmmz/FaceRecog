import 'dart:convert';
import 'package:facerecogapp/models/UserModel.dart';
import 'package:http/http.dart' as http;

class Registrationsevice {
  final baseUrl = 'http://10.0.2.2:3000';
  Usermodel? user;
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
    } else {
      throw Exception('Failed to register user: $url');
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final parseUrl = Uri.parse(
      '$baseUrl/auth/login',
    );
    
    final response = await http.post(parseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(
            {
            'email': email.toString(), 
            'password': password.toString()
            }
          ));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      print(decodedResponse['email']);
      return {
        'email': decodedResponse['email'],
        };
    } else {
      return {
        'error': true,
        'message':
            'Failed to log in. Status code: ${response.statusCode.toString()}',
      };
    }
  }
}
