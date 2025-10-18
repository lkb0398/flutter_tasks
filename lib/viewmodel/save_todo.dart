import 'package:flutter_tasks/model/todo_model.dart';

class SaveTodo {
  List<TodoModel> list = [];
  void addTodo(TodoModel todoModel) {
    list.add(todoModel);
    print(list.length);
  }
}
