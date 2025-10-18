import 'package:flutter/material.dart';
import 'package:flutter_tasks/view/todo_bottom_sheet.dart';
import 'package:flutter_tasks/view/todo_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: TodoView(),
      // NoTodoView(title: title),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return TodoBottomSheet();
            },
          );
        },
        backgroundColor: Colors.red,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
