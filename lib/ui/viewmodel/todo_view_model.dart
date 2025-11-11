import 'package:flutter_tasks/data/model/todo_model.dart';
import 'package:flutter_tasks/data/repository/todo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_view_model.g.dart';

@riverpod
TodoRepository todoRepository(Ref ref) {
  return TodoRepository();
}

@riverpod
class AddTodoModalState extends _$AddTodoModalState {
  @override
  AddTodoModalStateData build() {
    return AddTodoModalStateData(
      isDescription: false,
      isFavorite: false,
      titleText: '',
    );
  }

  void toggleDescription() {
    state = state.copyWith(isDescription: !state.isDescription);
  }

  void toggleFavorite() {
    state = state.copyWith(isFavorite: !state.isFavorite);
  }

  void updateTitleText(String text) {
    state = state.copyWith(titleText: text);
  }

  void reset() {
    state = AddTodoModalStateData(
      isDescription: false,
      isFavorite: false,
      titleText: '',
    );
  }
}

class AddTodoModalStateData {
  final bool isDescription;
  final bool isFavorite;
  final String titleText;

  AddTodoModalStateData({
    required this.isDescription,
    required this.isFavorite,
    required this.titleText,
  });

  AddTodoModalStateData copyWith({
    bool? isDescription,
    bool? isFavorite,
    String? titleText,
  }) {
    return AddTodoModalStateData(
      isDescription: isDescription ?? this.isDescription,
      isFavorite: isFavorite ?? this.isFavorite,
      titleText: titleText ?? this.titleText,
    );
  }
}

@riverpod
class TodoViewModel extends _$TodoViewModel {
  @override
  Future<List<TodoModel>> build() async {
    final repository = ref.read(todoRepositoryProvider);
    return await repository.getAll();
  }

  Future<void> addTodo(TodoModel todo) async {
    final repository = ref.read(todoRepositoryProvider);
    await repository.addTodo(todo);
    ref.invalidateSelf();
  }

  Future<void> updateTodo(TodoModel todo) async {
    final repository = ref.read(todoRepositoryProvider);
    await repository.updateTodo(todo);
    ref.invalidateSelf();
  }

  Future<void> toggleDone(TodoModel todo) async {
    final updatedTodo = todo.copyWith(isDone: !todo.isDone);
    await updateTodo(updatedTodo);
  }

  Future<void> toggleFavorite(TodoModel todo) async {
    final updatedTodo = todo.copyWith(isFavorite: !todo.isFavorite);
    await updateTodo(updatedTodo);
  }
}
