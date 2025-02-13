import 'dart:convert';

class Task {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority;
  final String status;
  final User createdBy;
  final User assignedTo;
  final int commentsCount;
  final int attachmentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.createdBy,
    required this.assignedTo,
    required this.commentsCount,
    required this.attachmentsCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['due_date']),
      priority: map['priority'],
      status: map['status'],
      createdBy: User.fromMap(map['created_by']),
      assignedTo: User.fromMap(map['assigned_to']),
      commentsCount: map['comments_count'],
      attachmentsCount: map['attachments_count'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task.fromMap(json);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate.toIso8601String(),
      'priority': priority,
      'status': status,
      'created_by': createdBy.toMap(),
      'assigned_to': assignedTo.toMap(),
      'comments_count': commentsCount,
      'attachments_count': attachmentsCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  int get totalWorkHours => dueDate.difference(createdAt).inHours;
  String toJson() => json.encode(toMap());
}

class User {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      avatar: map['avatar'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User.fromMap(json);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
