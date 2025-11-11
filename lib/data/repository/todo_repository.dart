import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tasks/data/model/todo_model.dart';

class TodoRepository {
  Future<List<TodoModel>> getAll() async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('tasks');
    final result = await collectionRef.get();
    final docs = result.docs
        .map((doc) => TodoModel.fromJson({...doc.data(), 'id': doc.id}))
        .toList();

    return docs;
  }

  Future<void> addTodo(TodoModel todo) async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('tasks');
    final docRef = collectionRef.doc();
    final todoWithId = todo.copyWith(id: docRef.id);
    await docRef.set(todoWithId.toJson());
  }

  Future<void> deletedTodo(TodoModel todo) {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('tasks');
    return collectionRef.doc(todo.id).delete();
  }

  Future<void> updateTodo(TodoModel todo) async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('tasks');
    await collectionRef.doc(todo.id).update(todo.toJson());
  }
}
