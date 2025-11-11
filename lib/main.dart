import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tasks/firebase_options.dart';
import 'package:flutter_tasks/ui/view/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // TodoModel todoModel = TodoModel(
  //   id: "nktmuQECQAL8bPXcnY1Y",
  //   title: "title",
  //   description: "description",
  //   isFavorite: false,
  //   isDone: false,
  // );
  // TodoRepository todoRepository = TodoRepository();
  // todoRepository.deletedTodo(todoModel);

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: "수강생 이름's Tasks"),
    );
  }
}
