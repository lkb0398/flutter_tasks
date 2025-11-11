import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tasks/data/model/todo_model.dart';
import 'package:flutter_tasks/ui/viewmodel/todo_view_model.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({super.key, required this.todoModel});
  final TodoModel todoModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoViewModelProvider);

    return todosAsync.when(
      data: (todos) {
        final currentTodo = todos.firstWhere(
          (todo) => todo.id == todoModel.id,
          orElse: () => todoModel,
        );

        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(currentTodo);
              },
              child: Icon(Icons.arrow_back),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  ref
                      .read(todoViewModelProvider.notifier)
                      .toggleFavorite(currentTodo);
                },
                child: currentTodo.isFavorite
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
                  currentTodo.title,
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
                  currentTodo.description.toString(),
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(todoModel);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(todoModel);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}
