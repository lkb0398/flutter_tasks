import 'package:flutter/material.dart';
import 'package:flutter_tasks/model/todo_model.dart';
import 'package:flutter_tasks/view/todo_view.dart';
import 'package:flutter_tasks/viewmodel/todo_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoViewModel todoViewModel = TodoViewModel();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<TodoModel> list = [];
  bool isFavorite = false;
  bool isDescription = false;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: list.isNotEmpty
          ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 12,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                list[index].isDone = !list[index].isDone;
                              });
                            },
                            child: list[index].isDone
                                ? Icon(Icons.check_circle_outlined, size: 20)
                                : Icon(Icons.circle_outlined, size: 20),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TodoView(todoModel: list[index]),
                                ),
                              );
                              setState(() {});
                            },
                            child: Text(
                              list[index].title,
                              style: TextStyle(
                                fontSize: 20,
                                decoration: list[index].isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            list[index].isFavorite = !list[index].isFavorite;
                          });
                        },
                        child: list[index].isFavorite
                            ? Icon(Icons.star, size: 24)
                            : Icon(Icons.star_border, size: 24),
                      ),
                    ],
                  ),
                );
              },
            )
          : Container(
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
                child: StatefulBuilder(
                  builder: (context, setModalState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          onChanged: (value) {
                            setModalState(() {});
                          },
                          controller: titleController,
                          autofocus: true,
                          style: TextStyle(fontSize: 16),
                          maxLines: 1,
                          onSubmitted: (value) {
                            list.add(
                              todoViewModel.saveTodo(
                                title: titleController.text,
                                description: descriptionController.text,
                                isFavorite: isFavorite,
                              ),
                            );
                            titleController.clear();
                            descriptionController.clear();
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: "새 할 일",
                            border: InputBorder.none,
                          ),
                        ),
                        Visibility(
                          visible: isDescription,
                          child: TextField(
                            controller: descriptionController,
                            style: TextStyle(fontSize: 14),
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: "세부사항",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setModalState(() {
                                      isDescription = !isDescription;
                                    });
                                  },
                                  child: Visibility(
                                    visible: !isDescription,
                                    child: Icon(
                                      Icons.short_text_rounded,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    setModalState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                  child: isFavorite
                                      ? Icon(Icons.star, size: 24)
                                      : Icon(Icons.star_border, size: 24),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: titleController.text.isNotEmpty
                                  ? () {
                                      list.add(
                                        todoViewModel.saveTodo(
                                          title: titleController.text,
                                          isFavorite: isFavorite,
                                          description:
                                              descriptionController.text,
                                        ),
                                      );
                                      titleController.clear();
                                      descriptionController.clear();
                                      Navigator.of(context).pop();
                                      setState(() {});
                                    }
                                  : null,
                              child: Text("저장"),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          );
          titleController.clear();
          descriptionController.clear();
          isDescription = false;
        },
      ),
    );
  }
}
