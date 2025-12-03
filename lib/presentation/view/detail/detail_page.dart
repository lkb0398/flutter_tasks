import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tasks/presentation/viewmodel/todo_view_model.dart';
import 'package:go_router/go_router.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoViewModelProvider);

    return todosAsync.when(
      data: (state) {
        if (state.todos.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () => context.go('/'),
                child: Icon(Icons.arrow_back),
              ),
            ),
            body: Center(child: Text('Todo를 찾을 수 없습니다.')),
          );
        }
        final currentTodo = state.todos.firstWhere(
          (todo) => todo.id == id,
          orElse: () => state.todos.first,
        );

        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => context.pop(),
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
                Hero(
                  tag: 'todo-${currentTodo.id}',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      currentTodo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
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
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}
