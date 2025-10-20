import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final bool isFavorite = false;

  void addTodo() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        height: 230,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 12,
          children: [
            Image.asset("assets/images/todo.webp"),
            Text(
              "아직 할 일 없음",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              "할 일을 추가하고 ${widget.title}에서 할 일을 추적하세요.",
              style: TextStyle(fontSize: 14, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: false,
        shape: CircleBorder(),
        backgroundColor: Colors.red,
        child: Icon(Icons.add, size: 24),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 12,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      autofocus: true,
                      style: TextStyle(fontSize: 16),
                      maxLines: 1,
                      onSubmitted: (value) {
                        Navigator.of(context).pop();
                      },
                      decoration: InputDecoration(
                        hintText: "새 할 일",
                        border: InputBorder.none,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        controller: descriptionController,
                        style: TextStyle(fontSize: 14),
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "세부사항",
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.short_text_rounded, size: 24),
                        Icon(Icons.star, size: 24),
                        ElevatedButton(onPressed: () {}, child: Text("저장")),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
