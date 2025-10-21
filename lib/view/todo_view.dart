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
    return Container(
      child: Row(
        children: [
          Icon(Icons.circle),
          
        ],
      ),
    );
  }
}
