import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> register(String username, String name, String phone, String email, String password) async {
    final Uri uri = Uri.parse('$baseUrl/register.php');
    final Map<String, String> body = {
      'username': username,
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    };

    final http.Response response = await http.post(uri, body: body);

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to Register: ${response.body}');
    }
  }

}
