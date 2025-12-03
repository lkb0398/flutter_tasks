import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TodoRemoteDataSource {
  Future<List<Map<String, dynamic>>> getAllTodos();
  Future<List<Map<String, dynamic>>> getTodos({
    required int limit,
    String? lastCreatedAt,
  });
  Future<void> addTodo(Map<String, dynamic> todoData);
  Future<void> updateTodo(String id, Map<String, dynamic> todoData);
  Future<void> deleteTodo(String id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore _firestore;

  TodoRemoteDataSourceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getAllTodos() async {
    final collectionRef = _firestore.collection('tasks');
    final result = await collectionRef
        .orderBy('created_at', descending: true)
        .get();
    return result.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final createdAt = data['created_at'];
      String createdAtString;
      if (createdAt is Timestamp) {
        createdAtString = createdAt.toDate().toIso8601String();
      } else if (createdAt is String) {
        createdAtString = createdAt;
      } else {
        createdAtString = DateTime.now().toIso8601String();
      }
      return <String, dynamic>{
        ...data,
        'id': doc.id,
        'created_at': createdAtString,
      };
    }).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getTodos({
    required int limit,
    String? lastCreatedAt,
  }) async {
    final collectionRef = _firestore.collection('tasks');
    Query query = collectionRef.orderBy('created_at', descending: true).limit(limit);
    
    if (lastCreatedAt != null) {
      final lastDateTime = DateTime.parse(lastCreatedAt);
      final lastTimestamp = Timestamp.fromDate(lastDateTime);
      query = query.startAfter([lastTimestamp]);
    }
    
    final result = await query.get();
    return result.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final createdAt = data['created_at'];
      String createdAtString;
      if (createdAt is Timestamp) {
        createdAtString = createdAt.toDate().toIso8601String();
      } else if (createdAt is String) {
        createdAtString = createdAt;
      } else {
        createdAtString = DateTime.now().toIso8601String();
      }
      return <String, dynamic>{
        ...data,
        'id': doc.id,
        'created_at': createdAtString,
      };
    }).toList();
  }

  @override
  Future<void> addTodo(Map<String, dynamic> todoData) async {
    final collectionRef = _firestore.collection('tasks');
    final docRef = collectionRef.doc();
    final now = Timestamp.now();
    await docRef.set({
      ...todoData,
      'id': docRef.id,
      'created_at': now,
    });
  }

  @override
  Future<void> updateTodo(String id, Map<String, dynamic> todoData) async {
    final collectionRef = _firestore.collection('tasks');
    await collectionRef.doc(id).update(todoData);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final collectionRef = _firestore.collection('tasks');
    await collectionRef.doc(id).delete();
  }
}
