import 'package:flutter_tasks/domain/model/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getAll();
  Future<List<TodoModel>> getTodos({
    required int limit,
    String? lastCreatedAt,
  });
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(TodoModel todo);
}
