import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  static const String path = '/calendar';
  static const String name = 'calendar';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> tasks = [
    {
      "title": "Research plan",
      "time": "09:00 - 10:30",
      "assignedTo": ["assets/user1.png"],
      "color": Colors.grey[800]
    },
    {
      "title": "Team Meeting",
      "time": "11:00 - 12:30",
      "assignedTo": ["assets/user2.png", "assets/user3.png"],
      "color": Colors.amber[600]
    },
    {
      "title": "Design review",
      "time": "12:30 - 02:00",
      "assignedTo": ["assets/user4.png"],
      "color": Colors.blue[400]
    },
    {
      "title": "PM Meeting",
      "time": "02:30 - 03:30",
      "assignedTo": ["assets/user5.png"],
      "color": Colors.purple[400]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Calendar", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildCalendarHeader(),
          Expanded(child: _buildTaskList()),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Column(
      children: [
        Text(
          DateFormat.yMMMM().format(selectedDate),
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildDaysRow(),
      ],
    );
  }

  Widget _buildDaysRow() {
    DateTime firstDayOfMonth =
        DateTime(selectedDate.year, selectedDate.month, 1);
    int daysInMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0).day;

    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysInMonth,
        itemBuilder: (context, index) {
          DateTime day = firstDayOfMonth.add(Duration(days: index));
          bool isSelected = day.day == selectedDate.day;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = day;
              });
            },
            child: Container(
              width: 50,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.E().format(day),
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    "${day.day}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = tasks[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task["time"],
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: task["color"],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task["title"],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: task["assignedTo"].map<Widget>((avatar) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage: AssetImage(avatar),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
