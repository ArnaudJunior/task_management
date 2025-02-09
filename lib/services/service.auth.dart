import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/config/config.api.dart';

class AuthService {
  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.baseUrl + ApiConfig.loginEndpoint),
        headers: ApiConfig.headers,
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['token'] != null) {
          await _saveToken(data['token']);
        } else {
          throw Exception('Token not found in response');
        }
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Failed to login');
      }
    } catch (e) {
      print('Login error: $e'); // Pour le débogage
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.baseUrl + ApiConfig.registerEndpoint),
        headers: ApiConfig.headers,
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['token'] != null) {
          await _saveToken(data['token']);
        } else {
          throw Exception('Token not found in response');
        }
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Failed to register');
      }
    } catch (e) {
      print('Register error: $e'); // Pour le débogage
      throw Exception('Failed to register: $e');
    }
  }

  Future<void> logout() async {
    try {
      final token = await getToken();
      if (token != null) {
        await http.post(
          Uri.parse(ApiConfig.baseUrl + ApiConfig.logoutEndpoint),
          headers: ApiConfig.authHeaders(token),
        );
      }
    } finally {
      await _removeToken();
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
