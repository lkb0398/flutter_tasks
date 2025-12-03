import 'package:flutter_tasks/domain/model/todo_model.dart';

class TodoListState {
  final List<TodoModel> todos;
  final bool hasMore;
  final bool isLoadingMore;

  TodoListState({
    required this.todos,
    required this.hasMore,
    required this.isLoadingMore,
  });

  TodoListState copyWith({
    List<TodoModel>? todos,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
