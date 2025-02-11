

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/screens/home/widget.home.dart';
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
            color: isSelected ? AppTheme.primaryColor : AppTheme.darkSurfaceColor,
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


class UserAssignment extends StatelessWidget {
  const UserAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildUserAvatar('https://i.pravatar.cc/150?img=1', 'John'),
          _buildUserAvatar('https://i.pravatar.cc/150?img=2', 'Sarah'),
          _buildUserAvatar('https://i.pravatar.cc/150?img=3', 'Mike'),
          _buildUserAvatar('https://i.pravatar.cc/150?img=4', 'Emma'),
          _buildUserAvatar('https://i.pravatar.cc/150?img=5', 'Alex'),
          _AddUserButton(),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(String imageUrl, String name) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: CircleAvatar(
        radius: 28,
        backgroundColor: AppTheme.darkSurfaceColor,
        backgroundImage: NetworkImage(imageUrl),
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

  const TaskDetailItem({
    super.key,
    required this.detail,
    required this.onDelete,
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
