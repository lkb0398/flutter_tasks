import 'package:flutter/material.dart';
import 'package:flutter_tasks/model/todo_model.dart';

class TodoView extends StatelessWidget {
  const TodoView({
    super.key,
    required this.todo,
    required this.onToggleFavorite,
    required this.onToggleDone,
  });

  final TodoModel todo;
  final VoidCallback onToggleFavorite;
  final VoidCallback onToggleDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, size: 10),
        Text("title", style: TextStyle(fontSize: 30)),
        Icon(Icons.star, size: 10),
      ],
    );
  }
}
