import 'package:flutter_tasks/domain/model/todo_model.dart';
import 'package:flutter_tasks/domain/repository/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository _repository;

  AddTodoUseCase(this._repository);

  Future<void> call(TodoModel todo) async {
    if (todo.title.trim().isEmpty) {
      throw Exception('Todo 제목은 비어있을 수 없습니다.');
    }
    await _repository.addTodo(todo);
  }
}
