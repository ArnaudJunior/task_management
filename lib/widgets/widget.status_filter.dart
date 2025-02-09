

import 'package:flutter/material.dart';
import 'package:task_management/theme/theme.app.dart';

class StatusFilter extends StatefulWidget {
  final Function(String) onStatusSelected;

  const StatusFilter({
    super.key,
    required this.onStatusSelected,
  });

  @override
  State<StatusFilter> createState() => _StatusFilterState();
}

class _StatusFilterState extends State<StatusFilter> {
  String _selectedStatus = 'to_do';

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        _buildFilterChip('To Do', 'to_do'),
        const SizedBox(width: 8),
        _buildFilterChip('In Progress', 'in_progress'),
        const SizedBox(width: 8),
        _buildFilterChip('On Review', 'on_review'),
        const SizedBox(width: 8),
        _buildFilterChip('Completed', 'completed'),
      ],
    );
  }

  Widget _buildFilterChip(String label, String status) {
    final isSelected = _selectedStatus == status;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatus = status;
        });
        widget.onStatusSelected(status);
      },
      backgroundColor: AppTheme.surfaceColor,
      selectedColor: AppTheme.primaryColor,
      checkmarkColor: Colors.white,
    );
  }
}
