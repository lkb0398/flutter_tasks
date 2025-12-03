import 'package:flutter_tasks/domain/model/todo_model.dart';
import 'package:flutter_tasks/domain/repository/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository _repository;

  DeleteTodoUseCase(this._repository);

  Future<void> call(TodoModel todo) async {
    await _repository.deleteTodo(todo);
  }
}
