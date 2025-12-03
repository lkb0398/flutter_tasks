import 'package:flutter_tasks/domain/model/todo_model.dart';
import 'package:flutter_tasks/domain/repository/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository _repository;

  UpdateTodoUseCase(this._repository);

  Future<void> call(TodoModel todo) async {
    await _repository.updateTodo(todo);
  }
}
