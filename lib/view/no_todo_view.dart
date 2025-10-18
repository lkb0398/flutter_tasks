import 'package:flutter/material.dart';

class NoTodoView extends StatelessWidget {
  const NoTodoView({super.key, required this.title});
  final title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/todo.webp"),
              SizedBox(height: 10),
              Text(
                "아직 할 일이 없습니다.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                """할 일을 추가하고 $title에서
                  할 일을 추척하세요.""",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
