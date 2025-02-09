

class Task {
  final int id;
  final String title;
  final String? description;
  final int createdBy;
  final int? assignedTo;
  final String status;
  final String priority;
  final DateTime dueDate;
  final int? estimatedTime;
  final int? trackedTime;
  final List<ChecklistItem> checklist;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.createdBy,
    this.assignedTo,
    required this.status,
    required this.priority,
    required this.dueDate,
    this.estimatedTime,
    this.trackedTime,
    required this.checklist,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      createdBy: json['createdBy'] as int,
      assignedTo: json['assignedTo'] as int?,
      status: json['status'] as String,
      priority: json['priority'] as String,
      dueDate: DateTime.parse(json['due_date'] as String),
      estimatedTime: json['estimated_time'] as int?,
      trackedTime: json['tracked_time'] as int?,
      checklist: (json['checklist'] as List<dynamic>)
          .map((e) => ChecklistItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'createdBy': createdBy,
        'assignedTo': assignedTo,
        'status': status,
        'priority': priority,
        'due_date': dueDate.toIso8601String(),
        'estimated_time': estimatedTime,
        'tracked_time': trackedTime,
        'checklist': checklist.map((e) => e.toJson()).toList(),
      };
}

class ChecklistItem {
  final int id;
  final String item;
  final bool isCompleted;
  final int order;

  ChecklistItem({
    required this.id,
    required this.item,
    required this.isCompleted,
    required this.order,
  });

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      id: json['id'] as int,
      item: json['item'] as String,
      isCompleted: json['is_completed'] as bool,
      order: json['order'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'item': item,
        'is_completed': isCompleted,
        'order': order,
      };
}
