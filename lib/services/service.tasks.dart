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
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (!responseData.containsKey('data')) {
          throw Exception('Réponse invalide : clé "data" non trouvée');
        }

        final List<dynamic> taskList = responseData['data'];
        return taskList.map((item) => Task.fromJson(item)).toList();
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Erreur inconue');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des tâches: $e');
    }
  }
}
