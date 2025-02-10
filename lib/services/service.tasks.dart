


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_management/config/config.api.dart';
import 'package:task_management/models/model.task.dart';
import 'package:task_management/services/service.auth.dart';

class TaskService {
  final AuthService _authService = AuthService();

  Future<List<Task>> getTasks() async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Non authentifié');
      }

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/tasks'),
        headers: ApiConfig.authHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Task.fromJson(json)).toList();
      } else {
        throw Exception('Échec du chargement des tâches');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des tâches: $e');
    }
  }
  
}
