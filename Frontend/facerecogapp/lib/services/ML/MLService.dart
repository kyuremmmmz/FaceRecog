import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class MLService {
  final baseUrl = 'http://192.168.100.7:5000';
  final expressURL = 'http://192.168.100.7:3000';
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
      Uint8List file1, Uint8List file2) async {
    final url = Uri.parse('$baseUrl/upload');
    final String base64File1 = base64Encode(file1);
    final String base64File2 = base64Encode(file2);

    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode({
            'file1': base64File1,
            'file2': base64File2,
          }));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedMessage = json.decode(response.body);
        return {
          'message': decodedMessage['message'],
          'distance': decodedMessage['distance'],
        };
      } else {
        print('Failed to predict image, status code: ${response.body}');
        return {'error': true, 'message': 'Failed to predict image'};
      }
    } catch (e) {
      print('Error predicting image: $e');
      return {'error': true, 'message': 'Failed to predict image: $e'};
    }
  }
}
