import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tasks/data/model/todo_model.dart';
import 'package:flutter_tasks/ui/view/detail/detail_page.dart';
import 'package:flutter_tasks/ui/viewmodel/todo_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(todoViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: todosAsync.when(
        data: (list) => list.isNotEmpty
            ? ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final todo = list[index];
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
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(todoViewModelProvider.notifier)
                                    .toggleDone(todo);
                              },
                              child: todo.isDone
                                  ? Icon(Icons.check_circle_outlined, size: 20)
                                  : Icon(Icons.circle_outlined, size: 20),
                            ),
                            SizedBox(width: 12),
                            GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(todoModel: todo),
                                  ),
                                );
                                ref.invalidate(todoViewModelProvider);
                              },
                              child: Text(
                                todo.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  decoration: todo.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            ref
                                .read(todoViewModelProvider.notifier)
                                .toggleFavorite(todo);
                          },
                          child: todo.isFavorite
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
                  children: [
                    Image.asset("assets/images/todo.webp"),
                    SizedBox(height: 12),
                    Text(
                      "아직 할 일 없음",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "할 일을 추가하고 ${widget.title}에서 할 일을 추적하세요.",
                      style: TextStyle(fontSize: 14, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
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
                child: Consumer(
                  builder: (context, ref, child) {
                    final modalState = ref.watch(addTodoModalStateProvider);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          onChanged: (value) {
                            ref
                                .read(addTodoModalStateProvider.notifier)
                                .updateTitleText(value);
                          },
                          controller: titleController,
                          autofocus: true,
                          style: TextStyle(fontSize: 16),
                          maxLines: 1,
                          onSubmitted: (value) {
                            ref
                                .read(todoViewModelProvider.notifier)
                                .addTodo(
                                  TodoModel(
                                    id: "",
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    isFavorite: modalState.isFavorite,
                                    isDone: false,
                                  ),
                                );
                            titleController.clear();
                            descriptionController.clear();
                            ref
                                .read(addTodoModalStateProvider.notifier)
                                .reset();
                            Navigator.of(context).pop();
                          },
                          decoration: InputDecoration(
                            hintText: "새 할 일",
                            border: InputBorder.none,
                          ),
                        ),
                        Visibility(
                          visible: modalState.isDescription,
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
                                    ref
                                        .read(
                                          addTodoModalStateProvider.notifier,
                                        )
                                        .toggleDescription();
                                  },
                                  child: Visibility(
                                    visible: !modalState.isDescription,
                                    child: Icon(
                                      Icons.short_text_rounded,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(
                                          addTodoModalStateProvider.notifier,
                                        )
                                        .toggleFavorite();
                                  },
                                  child: modalState.isFavorite
                                      ? Icon(Icons.star, size: 24)
                                      : Icon(Icons.star_border, size: 24),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: modalState.titleText.isNotEmpty
                                  ? () {
                                      ref
                                          .read(todoViewModelProvider.notifier)
                                          .addTodo(
                                            TodoModel(
                                              title: titleController.text,
                                              isFavorite: modalState.isFavorite,
                                              description:
                                                  descriptionController.text,
                                              id: '',
                                              isDone: false,
                                            ),
                                          );
                                      titleController.clear();
                                      descriptionController.clear();
                                      ref
                                          .read(
                                            addTodoModalStateProvider.notifier,
                                          )
                                          .reset();
                                      Navigator.of(context).pop();
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
          ref.read(addTodoModalStateProvider.notifier).reset();
        },
      ),
      bottomNavigationBar: Container(color: Colors.grey, height: 100),
    );
  }
}
