import 'package:flutter/material.dart';
import 'models/task.dart';
import 'widgets/task_tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Checklist App', home: TaskScreen());
  }
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];
  final TextEditingController controller = TextEditingController();

  void addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
    });
    controller.clear();
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Новая задача"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Введите текст"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              addTask(controller.text);
              Navigator.pop(context);
            },
            child: Text("Добавить"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checklist")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: tasks[index],
            onChanged: (_) => toggleTask(index),
            onDelete: () => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
