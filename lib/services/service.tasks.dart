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
        Uri.parse(ApiConfig.baseUrl + ApiConfig.getTasks),
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

  Future<Task> createTask({
    required String title,
    required String description,
    required DateTime dueDate,
    required String priority,
    required User assignedTo,
    required String status,
    required User createdBy,
  }) async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Non authentifié');
      }

      final response = await http.post(
        Uri.parse(ApiConfig.baseUrl + ApiConfig.createTask),
        headers: ApiConfig.authHeaders(token),
        body: json.encode({
          'title': title,
          'description': description,
          'due_date': dueDate.toIso8601String(),
          'priority': priority,
          'status': status,
          'assigned_to': assignedTo.toMap(),
          'created_by': createdBy.toMap(),
          'comments_count': 0,
          'attachments_count': 0,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return Task.fromJson(data);
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Échec de la création de la tâche');
      }
    } catch (e) {
      throw Exception('Erreur lors de la création de la tâche: $e');
    }
  }
}
