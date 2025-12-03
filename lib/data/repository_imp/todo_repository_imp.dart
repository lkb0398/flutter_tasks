import 'package:flutter_tasks/domain/model/todo_model.dart';
import 'package:flutter_tasks/domain/repository/todo_repository.dart';
import 'package:flutter_tasks/data/datasource/todo_remote_datasource.dart';

class TodoRepositoryImp implements TodoRepository {
  final TodoRemoteDataSource _dataSource;

  TodoRepositoryImp({TodoRemoteDataSource? dataSource})
    : _dataSource = dataSource ?? TodoRemoteDataSourceImpl();

  @override
  Future<List<TodoModel>> getAll() async {
    final data = await _dataSource.getAllTodos();
    return data.map((json) => TodoModel.fromJson(json)).toList();
  }

  @override
  Future<List<TodoModel>> getTodos({
    required int limit,
    String? lastCreatedAt,
  }) async {
    final data = await _dataSource.getTodos(
      limit: limit,
      lastCreatedAt: lastCreatedAt,
    );
    return data.map((json) => TodoModel.fromJson(json)).toList();
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    final todoData = todo.toJson();
    await _dataSource.addTodo(todoData);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final todoData = todo.toJson();
    todoData.remove('id');
    await _dataSource.updateTodo(todo.id, todoData);
  }

  @override
  Future<void> deleteTodo(TodoModel todo) async {
    await _dataSource.deleteTodo(todo.id);
  }
}
