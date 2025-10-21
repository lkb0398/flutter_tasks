import 'package:flutter_tasks/model/todo_model.dart';

class TodoViewModel {
  TodoModel saveTodo({
    required String title,
    required bool isFavorite,
    required String? description,
  }) {
    TodoModel todoModel = TodoModel(title, description, isFavorite);

    return todoModel;
  }
}
