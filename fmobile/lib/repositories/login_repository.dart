import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginRepository {
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      throw Exception('Failed to connect to server');
    }
  }
}
