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
    extends
        $FunctionalProvider<
          TodoRepositoryImp,
          TodoRepositoryImp,
          TodoRepositoryImp
        >
    with $Provider<TodoRepositoryImp> {
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
  $ProviderElement<TodoRepositoryImp> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TodoRepositoryImp create(Ref ref) {
    return todoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodoRepositoryImp value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodoRepositoryImp>(value),
    );
  }
}

String _$todoRepositoryHash() => r'72b54c603e4326116f514699ef7c1285c1592909';

@ProviderFor(getTodosUseCase)
const getTodosUseCaseProvider = GetTodosUseCaseProvider._();

final class GetTodosUseCaseProvider
    extends
        $FunctionalProvider<GetTodosUseCase, GetTodosUseCase, GetTodosUseCase>
    with $Provider<GetTodosUseCase> {
  const GetTodosUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTodosUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTodosUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTodosUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetTodosUseCase create(Ref ref) {
    return getTodosUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTodosUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTodosUseCase>(value),
    );
  }
}

String _$getTodosUseCaseHash() => r'0d9e38d58756272a17d4049cefcf08871245070b';

@ProviderFor(addTodoUseCase)
const addTodoUseCaseProvider = AddTodoUseCaseProvider._();

final class AddTodoUseCaseProvider
    extends $FunctionalProvider<AddTodoUseCase, AddTodoUseCase, AddTodoUseCase>
    with $Provider<AddTodoUseCase> {
  const AddTodoUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addTodoUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addTodoUseCaseHash();

  @$internal
  @override
  $ProviderElement<AddTodoUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddTodoUseCase create(Ref ref) {
    return addTodoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddTodoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddTodoUseCase>(value),
    );
  }
}

String _$addTodoUseCaseHash() => r'3b47eb224278e1d8aa1bd65f84e77897da713a1a';

@ProviderFor(updateTodoUseCase)
const updateTodoUseCaseProvider = UpdateTodoUseCaseProvider._();

final class UpdateTodoUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateTodoUseCase,
          UpdateTodoUseCase,
          UpdateTodoUseCase
        >
    with $Provider<UpdateTodoUseCase> {
  const UpdateTodoUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateTodoUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateTodoUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateTodoUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateTodoUseCase create(Ref ref) {
    return updateTodoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateTodoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateTodoUseCase>(value),
    );
  }
}

String _$updateTodoUseCaseHash() => r'62a62b5bee4c2b7247d8ab7074b42d3065392001';

@ProviderFor(deleteTodoUseCase)
const deleteTodoUseCaseProvider = DeleteTodoUseCaseProvider._();

final class DeleteTodoUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteTodoUseCase,
          DeleteTodoUseCase,
          DeleteTodoUseCase
        >
    with $Provider<DeleteTodoUseCase> {
  const DeleteTodoUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteTodoUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteTodoUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteTodoUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteTodoUseCase create(Ref ref) {
    return deleteTodoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteTodoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteTodoUseCase>(value),
    );
  }
}

String _$deleteTodoUseCaseHash() => r'21fdaa4c6c5d8801d53fb7fbe516bc16dcadca08';

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
    extends $AsyncNotifierProvider<TodoViewModel, TodoListState> {
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

String _$todoViewModelHash() => r'c6b7c4717d98867b120c080fecf877a61a78662c';

abstract class _$TodoViewModel extends $AsyncNotifier<TodoListState> {
  FutureOr<TodoListState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<TodoListState>, TodoListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TodoListState>, TodoListState>,
              AsyncValue<TodoListState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
