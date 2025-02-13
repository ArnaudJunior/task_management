import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/models/model.task.dart';
import 'package:task_management/screens/home/widget.home.dart';
import 'package:task_management/services/service.auth.dart';
import 'package:task_management/services/service.tasks.dart';
import 'package:task_management/theme/theme.app.dart';

part 'screen.tasks.dart';

class PrioritySelector extends StatelessWidget {
  final String selectedPriority;
  final Function(String) onPrioritySelected;

  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onPrioritySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PriorityButton(
          label: 'High',
          isSelected: selectedPriority == 'high',
          onTap: () => onPrioritySelected('high'),
        ),
        const SizedBox(width: 12),
        _PriorityButton(
          label: 'Medium',
          isSelected: selectedPriority == 'medium',
          onTap: () => onPrioritySelected('medium'),
        ),
        const SizedBox(width: 12),
        _PriorityButton(
          label: 'Low',
          isSelected: selectedPriority == 'low',
          onTap: () => onPrioritySelected('low'),
        ),
      ],
    );
  }
}

class _PriorityButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PriorityButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color:
                isSelected ? AppTheme.primaryColor : AppTheme.darkSurfaceColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class UserAssignment extends StatefulWidget {
  final Function(int?) onUserSelected;

  const UserAssignment({
    super.key,
    required this.onUserSelected,
  });

  @override
  State<UserAssignment> createState() => _UserAssignmentState();
}

class _UserAssignmentState extends State<UserAssignment> {
  List<User> _users = [];
  int? _selectedUserId;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      // TODO: Implement get users from API
      // For now, using mock data
      setState(() {
        _users = [
          User(
            id: 1,
            name: "John Doe",
            email: "john@example.com",
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          User(
            id: 2,
            name: "Jane Smith",
            email: "jane@example.com",
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];
      });
    } catch (e) {
      print('Error loading users: $e');
    }
  }

  void _selectUser(int userId) {
    setState(() {
      _selectedUserId = userId == _selectedUserId ? null : userId;
    });
    widget.onUserSelected(_selectedUserId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ..._users.map((user) => _buildUserAvatar(
                user.avatar ?? 'https://i.pravatar.cc/150?img=${user.id}',
                user.name,
                user.id,
              )),
          _AddUserButton(),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(String imageUrl, String name, int userId) {
    final isSelected = userId == _selectedUserId;
    return GestureDetector(
      onTap: () => _selectUser(userId),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: AppTheme.primaryColor, width: 2)
              : null,
        ),
        child: CircleAvatar(
          radius: 28,
          backgroundColor: AppTheme.darkSurfaceColor,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}

class _AddUserButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey[600]!,
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.add,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

class AttachmentItem extends StatelessWidget {
  final String fileName;

  const AttachmentItem({
    super.key,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.insert_drive_file,
            color: Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class TaskDetailItem extends StatelessWidget {
  final String detail;
  final VoidCallback onDelete;
  final Function(String) onChanged;

  const TaskDetailItem({
    super.key,
    required this.detail,
    required this.onDelete,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.drag_indicator,
            color: Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              initialValue: detail,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter task detail',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: onChanged,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.grey,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
