// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(todoRepository)
const todoRepositoryProvider = TodoRepositoryProvider._();

final class TodoRepositoryProvider
    extends $FunctionalProvider<TodoRepository, TodoRepository, TodoRepository>
    with $Provider<TodoRepository> {
  const TodoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoRepositoryHash();

  @$internal
  @override
  $ProviderElement<TodoRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TodoRepository create(Ref ref) {
    return todoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodoRepository>(value),
    );
  }
}

String _$todoRepositoryHash() => r'ca54e3b96bafcf7508a902deb80cfcb1c7f4556e';

@ProviderFor(AddTodoModalState)
const addTodoModalStateProvider = AddTodoModalStateProvider._();

final class AddTodoModalStateProvider
    extends $NotifierProvider<AddTodoModalState, AddTodoModalStateData> {
  const AddTodoModalStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addTodoModalStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addTodoModalStateHash();

  @$internal
  @override
  AddTodoModalState create() => AddTodoModalState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddTodoModalStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddTodoModalStateData>(value),
    );
  }
}

String _$addTodoModalStateHash() => r'61dee789d6b088b3a4e7f663f2b7a02ca66e9b09';

abstract class _$AddTodoModalState extends $Notifier<AddTodoModalStateData> {
  AddTodoModalStateData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AddTodoModalStateData, AddTodoModalStateData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AddTodoModalStateData, AddTodoModalStateData>,
              AddTodoModalStateData,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(TodoViewModel)
const todoViewModelProvider = TodoViewModelProvider._();

final class TodoViewModelProvider
    extends $AsyncNotifierProvider<TodoViewModel, List<TodoModel>> {
  const TodoViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoViewModelHash();

  @$internal
  @override
  TodoViewModel create() => TodoViewModel();
}

String _$todoViewModelHash() => r'd315babb87bb064af5a79951477cd4293cd189b6';

abstract class _$TodoViewModel extends $AsyncNotifier<List<TodoModel>> {
  FutureOr<List<TodoModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<TodoModel>>, List<TodoModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<TodoModel>>, List<TodoModel>>,
              AsyncValue<List<TodoModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
