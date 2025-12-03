import 'package:flutter_tasks/domain/model/todo_model.dart';
import 'package:flutter_tasks/domain/usecase/add_todo_usecase.dart';
import 'package:flutter_tasks/domain/usecase/delete_todo_usecase.dart';
import 'package:flutter_tasks/domain/usecase/get_todos_usecase.dart';
import 'package:flutter_tasks/domain/usecase/update_todo_usecase.dart';
import 'package:flutter_tasks/data/repository_imp/todo_repository_imp.dart';
import 'package:flutter_tasks/presentation/state/add_todo_modal_state.dart';
import 'package:flutter_tasks/presentation/state/todo_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_view_model.g.dart';

@riverpod
TodoRepositoryImp todoRepository(Ref ref) {
  return TodoRepositoryImp();
}

@riverpod
GetTodosUseCase getTodosUseCase(Ref ref) {
  return GetTodosUseCase(ref.read(todoRepositoryProvider));
}

@riverpod
AddTodoUseCase addTodoUseCase(Ref ref) {
  return AddTodoUseCase(ref.read(todoRepositoryProvider));
}

@riverpod
UpdateTodoUseCase updateTodoUseCase(Ref ref) {
  return UpdateTodoUseCase(ref.read(todoRepositoryProvider));
}

@riverpod
DeleteTodoUseCase deleteTodoUseCase(Ref ref) {
  return DeleteTodoUseCase(ref.read(todoRepositoryProvider));
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

@riverpod
class TodoViewModel extends _$TodoViewModel {
  static const int _pageSize = 15;

  @override
  Future<TodoListState> build() async {
    return await _loadInitialTodos();
  }

  Future<TodoListState> _loadInitialTodos() async {
    final useCase = ref.read(getTodosUseCaseProvider);
    final todos = await useCase(limit: _pageSize);
    return TodoListState(
      todos: todos,
      hasMore: todos.length == _pageSize,
      isLoadingMore: false,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadInitialTodos());
  }

  Future<void> loadMore() async {
    if (!state.hasValue) return;
    final currentState = state.value!;
    if (!currentState.hasMore || currentState.isLoadingMore) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    try {
      final useCase = ref.read(getTodosUseCaseProvider);
      final lastCreatedAt = currentState.todos.isNotEmpty
          ? currentState.todos.last.createdAt
          : null;

      final newTodos = await useCase(
        limit: _pageSize,
        lastCreatedAt: lastCreatedAt,
      );

      final updatedState = currentState.copyWith(
        todos: [...currentState.todos, ...newTodos],
        hasMore: newTodos.length == _pageSize,
        isLoadingMore: false,
      );

      state = AsyncValue.data(updatedState);
    } catch (e, stack) {
      state = AsyncValue.data(currentState.copyWith(isLoadingMore: false));
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addTodo(TodoModel todo) async {
    final useCase = ref.read(addTodoUseCaseProvider);
    final now = DateTime.now().toIso8601String();
    final todoWithCreatedAt = todo.copyWith(createdAt: now);
    await useCase(todoWithCreatedAt);
    await refresh();
  }

  Future<void> deleteTodo(TodoModel todo) async {
    final useCase = ref.read(deleteTodoUseCaseProvider);
    await useCase(todo);
    if (!state.hasValue) return;
    final currentState = state.value!;
    final updatedTodos = currentState.todos
        .where((t) => t.id != todo.id)
        .toList();
    state = AsyncValue.data(currentState.copyWith(todos: updatedTodos));
  }

  Future<void> updateTodo(TodoModel todo) async {
    final useCase = ref.read(updateTodoUseCaseProvider);
    await useCase(todo);
    if (!state.hasValue) return;
    final currentState = state.value!;
    final updatedTodos = currentState.todos.map((t) {
      return t.id == todo.id ? todo : t;
    }).toList();
    state = AsyncValue.data(currentState.copyWith(todos: updatedTodos));
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
