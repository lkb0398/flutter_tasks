import 'package:flutter_tasks/domain/model/todo_model.dart';
import 'package:flutter_tasks/domain/repository/todo_repository.dart';

class GetTodosUseCase {
  final TodoRepository _repository;

  GetTodosUseCase(this._repository);

  Future<List<TodoModel>> call({
    required int limit,
    String? lastCreatedAt,
  }) async {
    return await _repository.getTodos(
      limit: limit,
      lastCreatedAt: lastCreatedAt,
    );
  }
}
