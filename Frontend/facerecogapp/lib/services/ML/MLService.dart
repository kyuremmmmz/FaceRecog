import 'dart:convert';

import 'package:http/http.dart' as http;

class MLService {
  final baseUrl = 'http://10.0.2.2:500';
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
      final decodedMessage = json.decode(response.body);
      print(decodedMessage[0]['distance']);
      return {
        'message': decodedMessage,
      };
    }else{
      return {
        'error': true,
        'message': 'Failed to predict image: $response'
      };
    }
  }
}
