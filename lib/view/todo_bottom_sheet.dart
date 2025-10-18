import 'package:flutter/material.dart';
import 'package:flutter_tasks/model/todo_model.dart';
import 'package:flutter_tasks/viewmodel/save_todo.dart';

class TodoBottomSheet extends StatefulWidget {
  const TodoBottomSheet({super.key});

  @override
  State<TodoBottomSheet> createState() => _TodoBottomSheetState();
}

class _TodoBottomSheetState extends State<TodoBottomSheet> {
  bool isDetail = false;
  bool isFavorite = false;
  bool isSaveButtonDisable = true;
  TodoModel todoModel = TodoModel("", "", false, false);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  if (titleController.text.isEmpty) {
                    isSaveButtonDisable = true;
                  } else {
                    isSaveButtonDisable = false;
                  }
                });
              },
              controller: titleController,
              textInputAction: TextInputAction.done,
              maxLines: 1,
              style: TextStyle(fontSize: 16),
              autofocus: true,
              onSubmitted: (value) {
                todoModel = TodoModel(
                  titleController.text,
                  detailController.text,
                  isFavorite,
                  false,
                );
                SaveTodo().addTodo(todoModel);
                Navigator.of(context).pop();
              },
              decoration: InputDecoration(
                hintText: "새 할 일",
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            Visibility(
              visible: isDetail,
              child: TextField(
                controller: detailController,
                textInputAction: TextInputAction.done,
                maxLines: 3,
                style: TextStyle(fontSize: 16),
                autofocus: true,
                autocorrect: true,
                onSubmitted: (value) {
                  TodoModel todoModel = TodoModel(
                    titleController.text,
                    detailController.text,
                    isFavorite,
                    false,
                  );
                  SaveTodo().addTodo(todoModel);
                  Navigator.of(context).pop();
                },
                decoration: InputDecoration(
                  hintText: "세부정보 추가",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            Row(
              children: [
                Visibility(
                  visible: !isDetail,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isDetail = true;
                      });
                    },
                    child: Icon(Icons.short_text_rounded, size: 24),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: isFavorite
                      ? Icon(Icons.star, size: 24)
                      : Icon(Icons.star_border, size: 24),
                ),
                SizedBox(width: 200),
                ElevatedButton(
                  onPressed: isSaveButtonDisable
                      ? null
                      : () {
                          TodoModel todoModel = TodoModel(
                            titleController.text,
                            detailController.text,
                            isFavorite,
                            false,
                          );
                          SaveTodo().addTodo(todoModel);
                          Navigator.of(context).pop();
                        },
                  child: Text("저장"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
