import 'package:flutter/material.dart';
import 'package:flutter_tasks/model/todo_model.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key, required this.todoModel});
  final TodoModel todoModel;

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.todoModel.isFavorite = !widget.todoModel.isFavorite;
              });
            },
            child: widget.todoModel.isFavorite
                ? Icon(Icons.star)
                : Icon(Icons.star_border),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.todoModel.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Row(
              spacing: 5,
              children: [
                Icon(Icons.short_text),
                Text("세부 내용은 다음과 같습니다.", style: TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(height: 10),
            Text(
              widget.todoModel.description.toString(),
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
