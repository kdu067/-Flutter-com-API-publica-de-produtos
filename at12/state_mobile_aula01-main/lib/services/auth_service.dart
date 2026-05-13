import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class AuthService {
  static const String _baseUrl = 'https://dummyjson.com/auth';

  /// Realiza login na DummyJSON
  Future<User> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return User.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception('Credenciais inválidas');
      } else {
        throw Exception('Erro ao fazer login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar ao servidor: $e');
    }
  }
}
