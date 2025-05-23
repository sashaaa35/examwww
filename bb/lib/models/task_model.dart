// task_model.dart

enum TaskStatus { pending, inProgress, completed, archived }

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskStatus status;
  final int priority; // От 1 (высокий) до 5 (низкий)
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.priority,
    required this.createdAt,
  });

  // Метод для изменения статуса задачи
  Task copyWith({TaskStatus? status}) {
    return Task(
      id: id,
      title: title,
      description: description,
      dueDate: dueDate,
      status: status ?? this.status,
      priority: priority,
      createdAt: createdAt,
    );
  }

  // Преобразование объекта в карту для сохранения в базе данных или передачи
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Преобразование карты обратно в объект Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dueDate: DateTime.parse(map['dueDate']),
      status: TaskStatus.values.firstWhere(
        (e) => e.toString().split('.').last == map['status'],
      ),
      priority: map['priority'] ?? 3,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  // Преобразование объекта в строку
  @override
  String toString() {
    return 'Task{id: $id, title: $title, status: $status, priority: $priority}';
  }
}
