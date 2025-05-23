import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bb/models/task_model.dart'; // Исправь путь в зависимости от твоего проекта

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Добавление новой задачи
  Future<void> addTask(Task task) async {
    try {
      await _firestore.collection('tasks').doc(task.id).set(task.toMap());
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  // Получение списка задач
  Stream<List<Task>> getTasks() {
    return _firestore.collection('tasks').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList());
  }

  // Обновление задачи
  Future<void> updateTask(Task task) async {
    try {
      await _firestore.collection('tasks').doc(task.id).update(task.toMap());
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  // Удаление задачи
  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
