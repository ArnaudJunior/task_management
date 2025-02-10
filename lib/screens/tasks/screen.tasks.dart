part of 'widget.tasks.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  static const String path = '/addtask';
  static const String name = 'AddTaskScreen';

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _dueDate;
  String _priority = 'High';
  List<User> _assignedUsers = [];
  List<String> _attachments = [];

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _dueDate = picked;
        }
      });
    }
  }

  void _submitTask() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _dueDate != null) {
      // Handle API call here
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Icon(Icons.check_circle, color: Colors.green, size: 60),
          content: Text("Successfully created new task!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back to Home"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Task Name"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Start Date"),
                        TextButton(
                          onPressed: () => _selectDate(context, true),
                          child: Text(_startDate != null
                              ? DateFormat.yMd().format(_startDate!)
                              : "Select Date"),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Due Date"),
                        TextButton(
                          onPressed: () => _selectDate(context, false),
                          child: Text(_dueDate != null
                              ? DateFormat.yMd().format(_dueDate!)
                              : "Select Date"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              DropdownButton<String>(
                value: _priority,
                items: ["High", "Medium", "Low"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _priority = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTask,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
