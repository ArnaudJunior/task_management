

import 'package:flutter/material.dart';
import 'package:task_management/models/model.task.dart';
import 'package:task_management/theme/theme.app.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  Color _getPriorityColor() {
    switch (task.priority) {
      case 'high':
        return AppTheme.highPriorityColor;
      case 'medium':
        return AppTheme.mediumPriorityColor;
      case 'low':
        return AppTheme.lowPriorityColor;
      default:
        return AppTheme.lowPriorityColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.darkTaskCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to task details
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${task.priority} Priority',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                task.description ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Due ${task.dueDate.toString().split(' ')[0]}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
