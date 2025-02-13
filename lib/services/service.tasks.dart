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
    required int assignedTo,
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
          'assigned_to': assignedTo,
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

  Future<Task> updateTask({
    required int taskId,
    required String? title,
    required String? description,
    required DateTime dueDate,
    required String? priority,
    required int assignedTo,
    required String status,
    required User createdBy,
    required int? commentsCount,
    required int? attachmentsCount,

  })
  async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Non authentifié');
      }
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/tasks/$taskId'),
        headers: ApiConfig.authHeaders(token),
        body: json.encode({
          'title': title,
          'description': description,
          'due_date': dueDate.toIso8601String(),
          'priority': priority,
          'assigned_to': assignedTo,
         'status': status,
          'created_by': createdBy.toMap(),
          'comments_count': commentsCount,
          'attachments_count': attachmentsCount,
          'updated_at': DateTime.now().toIso8601String(),
        }),
      );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Task.fromJson(data);
    } else {
      final error = json.decode(response.body);
      throw Exception(error['message']?? 'Échec de la mise à jour de la tâche');
    }
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour de la tâche: $e');
    }
  }



  // Future<Task> updateTask({
  //   required int taskId,
  //   required String title,
  //   required String description,
  //   required DateTime dueDate,
  //   required String priority,
  //   required String status,
  //   int? assignedTo,
  //   List<Map<String, dynamic>>? checklist,
  // }) async {
  //   try {
  //     final token = await _authService.getToken();
  //     if (token == null) {
  //       throw Exception('Non authentifié');
  //     }

  //     final response = await http.put(
  //       Uri.parse('${ApiConfig.baseUrl}/tasks/$taskId'),
  //       headers: ApiConfig.authHeaders(token),
  //       body: json.encode({
  //         'title': title,
  //         'description': description,
  //         'due_date': dueDate.toIso8601String(),
  //         'priority': priority,
  //         'status': status,
  //         'assigned_to': assignedTo,
  //         'checklist': checklist,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return Task.fromJson(data);
  //     } else {
  //       final error = json.decode(response.body);
  //       throw Exception(
  //           error['message'] ?? 'Échec de la mise à jour de la tâche');
  //     }
  //   } catch (e) {
  //     throw Exception('Erreur lors de la mise à jour de la tâche: $e');
  //   }
  // }

  Future<void> deleteTask(int taskId) async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Non authentifié');
      }

      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}/tasks/$taskId'),
        headers: ApiConfig.authHeaders(token),
      );

      if (response.statusCode != 204) {
        final error = json.decode(response.body);
        throw Exception(
            error['message'] ?? 'Échec de la suppression de la tâche');
      }
    } catch (e) {
      throw Exception('Erreur lors de la suppression de la tâche: $e');
    }
  }

  Future<Task> updateTaskStatus(int taskId, String status) async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Non authentifié');
      }

      final response = await http.patch(
        Uri.parse('${ApiConfig.baseUrl}/tasks/$taskId/status'),
        headers: ApiConfig.authHeaders(token),
        body: json.encode({'status': status}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Task.fromJson(data);
      } else {
        final error = json.decode(response.body);
        throw Exception(
            error['message'] ?? 'Échec de la mise à jour du statut');
      }
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du statut: $e');
    }
  }
}
