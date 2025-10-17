import 'package:flutter/material.dart';

class TodoBottomSheet extends StatefulWidget {
  const TodoBottomSheet({super.key});

  @override
  State<TodoBottomSheet> createState() => _TodoBottomSheetState();
}

class _TodoBottomSheetState extends State<TodoBottomSheet> {
  bool isDetail = false;
  bool isStar = false;
  bool isSaveButtonDisable = true;

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
              maxLines: 1,
              style: TextStyle(fontSize: 16),
              autofocus: true,
              decoration: InputDecoration(
                hintText: "새 할 일",
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            Visibility(
              visible: isDetail,
              child: TextField(
                controller: detailController,
                maxLines: 1,
                style: TextStyle(fontSize: 16),
                autofocus: true,
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
                      isStar = !isStar;
                    });
                  },
                  child: isStar
                      ? Icon(Icons.star, size: 24)
                      : Icon(Icons.star_border, size: 24),
                ),
                ElevatedButton(
                  onPressed: isSaveButtonDisable
                      ? null
                      : () {
                          print("Title Controller: ${titleController.text}");
                          print("Detail Controller: ${detailController.text}");
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
