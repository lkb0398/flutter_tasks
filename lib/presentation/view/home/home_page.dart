import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tasks/domain/model/todo_model.dart';
import 'package:flutter_tasks/presentation/viewmodel/todo_view_model.dart';
import 'package:flutter_tasks/presentation/viewmodel/weather_info_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _weatherUpdateTimer;
  Timer? _timeUpdateTimer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Firebase에 50개의 Todo 데이터 추가
    // for (int i = 0; i < 50; i++) {
    //   ref
    //       .read(todoViewModelProvider.notifier)
    //       .addTodo(
    //         TodoModel(
    //           id: '', // Firestore에서 자동 생성하거나 적절히 처리
    //           title: '할일 $i',
    //           description: "",
    //           createdAt: DateTime.now().toIso8601String(),
    //           isDone: false,
    //           isFavorite: false,
    //         ),
    //       );
    // }
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _weatherUpdateTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
        if (mounted) {
          ref.read(weatherInfoViewModelProvider.notifier).refresh();
        }
      });
      _timeUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _currentTime = DateTime.now();
          });
        }
      });
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      ref.read(todoViewModelProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _weatherUpdateTimer?.cancel();
    _timeUpdateTimer?.cancel();
    _scrollController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(todoViewModelProvider);
    final weatherAsync = ref.watch(weatherInfoViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: todosAsync.when(
        data: (state) => state.todos.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  await ref.read(todoViewModelProvider.notifier).refresh();
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.todos.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.todos.length) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: state.isLoadingMore
                              ? CircularProgressIndicator()
                              : SizedBox.shrink(),
                        ),
                      );
                    }
                    final todo = state.todos[index];
                    return Hero(
                      tag: 'todo-${todo.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 31, 31, 31),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(todoViewModelProvider.notifier)
                                          .toggleDone(todo);
                                    },
                                    child: todo.isDone
                                        ? Icon(
                                            Icons.check_circle_outlined,
                                            size: 20,
                                          )
                                        : Icon(Icons.circle_outlined, size: 20),
                                  ),
                                  SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () {
                                      context.push('/detail/${todo.id}');
                                    },
                                    child: Text(
                                      todo.title,
                                      style: TextStyle(
                                        fontSize: 20,
                                        decoration: todo.isDone
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(todoViewModelProvider.notifier)
                                          .toggleFavorite(todo);
                                    },
                                    child: todo.isFavorite
                                        ? Icon(Icons.star, size: 24)
                                        : Icon(Icons.star_border, size: 24),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(todoViewModelProvider.notifier)
                                          .deleteTodo(todo);
                                    },
                                    child: Icon(Icons.delete, size: 24),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await ref.read(todoViewModelProvider.notifier).refresh();
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 31, 31, 31),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    height: 230,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Image.asset("assets/images/todo.webp"),
                        SizedBox(height: 12),
                        Text(
                          "아직 할 일 없음",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "할 일을 추가하고 ${widget.title}에서 할 일을 추적하세요.",
                          style: TextStyle(fontSize: 14, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: false,
        shape: CircleBorder(),
        backgroundColor: Colors.red,
        child: Icon(Icons.add, size: 24),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => _AddTodoModal(
              titleController: titleController,
              descriptionController: descriptionController,
            ),
          );
          titleController.clear();
          descriptionController.clear();
          ref.read(addTodoModalStateProvider.notifier).reset();
        },
      ),
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 31, 31, 31),
        padding: EdgeInsets.all(16),
        child: weatherAsync.when(
          data: (state) {
            final dateFormat = DateFormat('yy년 MM월 dd일 HH시 mm분');
            final formattedTime = dateFormat.format(_currentTime);
            final isDay = state.weather.isDay == 1;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '현재 시간 : $formattedTime (',
                      style: TextStyle(fontSize: 14),
                    ),
                    Icon(
                      isDay ? Icons.wb_sunny : Icons.nightlight_round,
                      size: 16,
                      color: Colors.white,
                    ),
                    Text(')', style: TextStyle(fontSize: 14)),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  '날씨: ${state.weather.weatherDescription} '
                  '온도: ${state.weather.temperature.toStringAsFixed(1)}℃ '
                  '풍속: ${state.weather.windSpeed.toStringAsFixed(1)}m/s',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.right,
                ),
              ],
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text(
            '날씨 정보를 불러올 수 없습니다: $error',
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class _AddTodoModal extends ConsumerStatefulWidget {
  const _AddTodoModal({
    required this.titleController,
    required this.descriptionController,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  ConsumerState<_AddTodoModal> createState() => _AddTodoModalState();
}

class _AddTodoModalState extends ConsumerState<_AddTodoModal> {
  @override
  Widget build(BuildContext context) {
    final modalState = ref.watch(addTodoModalStateProvider);
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              ref
                  .read(addTodoModalStateProvider.notifier)
                  .updateTitleText(value);
            },
            controller: widget.titleController,
            autofocus: true,
            style: TextStyle(fontSize: 16),
            maxLines: 1,
            onSubmitted: (value) {
              ref
                  .read(todoViewModelProvider.notifier)
                  .addTodo(
                    TodoModel(
                      id: "",
                      title: widget.titleController.text,
                      description: widget.descriptionController.text,
                      isFavorite: modalState.isFavorite,
                      isDone: false,
                      createdAt: DateTime.now().toIso8601String(),
                    ),
                  );
              widget.titleController.clear();
              widget.descriptionController.clear();
              ref.read(addTodoModalStateProvider.notifier).reset();
              Navigator.of(context).pop();
            },
            decoration: InputDecoration(
              hintText: "새 할 일",
              border: InputBorder.none,
            ),
          ),
          Visibility(
            visible: modalState.isDescription,
            child: TextField(
              controller: widget.descriptionController,
              style: TextStyle(fontSize: 14),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "세부사항",
                border: InputBorder.none,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(addTodoModalStateProvider.notifier)
                          .toggleDescription();
                    },
                    child: Visibility(
                      visible: !modalState.isDescription,
                      child: Icon(Icons.short_text_rounded, size: 24),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(addTodoModalStateProvider.notifier)
                          .toggleFavorite();
                    },
                    child: modalState.isFavorite
                        ? Icon(Icons.star, size: 24)
                        : Icon(Icons.star_border, size: 24),
                  ),
                ],
              ),
              TapDebouncer(
                cooldown: Duration(seconds: 3),
                builder: (BuildContext context, VoidCallback? onTap) {
                  return ElevatedButton(
                    onPressed: modalState.titleText.isNotEmpty
                        ? () {
                            ref
                                .read(todoViewModelProvider.notifier)
                                .addTodo(
                                  TodoModel(
                                    title: widget.titleController.text,
                                    isFavorite: modalState.isFavorite,
                                    description:
                                        widget.descriptionController.text,
                                    id: '',
                                    isDone: false,
                                    createdAt: DateTime.now().toIso8601String(),
                                  ),
                                );
                            widget.titleController.clear();
                            widget.descriptionController.clear();
                            ref
                                .read(addTodoModalStateProvider.notifier)
                                .reset();
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: Text("저장"),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
