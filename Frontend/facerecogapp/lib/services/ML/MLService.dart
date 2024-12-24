import 'dart:convert';

import 'package:http/http.dart' as http;

class MLService {
  final baseUrl = 'http://10.0.2.2:5000';
  final expressURL = 'http://10.0.2.2:3000';
  String? image;

  Future<Map<String, dynamic>> getImage(String studentID) async {
    try {
      final url = Uri.parse('$expressURL/getstudent');
      print('Making request to: $url with studentID: $studentID');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode({
            'studentID': studentID,
          }));

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final decodedResponse = await json.decode(response.body);
        print('Decoded response: $decodedResponse');
        image = decodedResponse['student']['imagePath'];
        print('Image Path: $image');
        return {
          'imagePath': image,
        };
      } else {
        print('Failed to load image, status code: ${response.statusCode}');
        return {'error': true, 'message': 'Failed to get image: $response'};
      }
    } catch (e) {
      print('Error getting image: $e');
      return {'error': true, 'message': 'Failed to get image: $e'};
    }
  }

  Future<Map<String, dynamic>> predictImage(
      num destination, String message) async {
    final url = Uri.parse('$baseUrl/upload');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'destination': destination,
          'message': message,
        }));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedMessage = json.decode(response.body);
      print(decodedMessage['distance']);
      return {
        'message': decodedMessage,
      };
    } else {
      return {'error': true, 'message': 'Failed to predict image: $response'};
    }
  }
}
