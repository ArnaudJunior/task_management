
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/models/model.task.dart';
import 'package:task_management/screens/calendar/widget.calendar.dart';
import 'package:task_management/screens/edit_tasks/widget.edit_tasks.dart';
import 'package:task_management/theme/theme.app.dart';

part 'screen.task_detail.dart';

class UserAvatarGroup extends StatelessWidget {
  final List<User> users;
  final double size;
  final double overlap;

  const UserAvatarGroup({
    super.key,
    required this.users,
    this.size = 32,
    this.overlap = 0.4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: users.length * size * (1 - overlap) + size * overlap,
      height: size,
      child: Stack(
        children: List.generate(users.length, (index) {
          return Positioned(
            left: index * size * (1 - overlap),
            child: CircleAvatar(
              radius: size / 2,
              backgroundColor: Colors.grey[800],
              backgroundImage: users[index].avatar != null
                  ? NetworkImage(users[index].avatar!)
                  : null,
              child: users[index].avatar == null
                  ? Text(
                      users[index].name[0].toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size * 0.4,
                      ),
                    )
                  : null,
            ),
          );
        }),
      ),
    );
  }
}
