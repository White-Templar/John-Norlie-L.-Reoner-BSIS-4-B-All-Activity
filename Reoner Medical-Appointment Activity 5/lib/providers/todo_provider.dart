import 'package:flutter/material.dart';

class TodoItem {
  final String id;
  String title;
  String description;
  bool isCompleted;
  DateTime createdAt;
  DateTime? completedAt;

  TodoItem({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    required this.createdAt,
    this.completedAt,
  });
}

class TodoProvider extends ChangeNotifier {
  final List<TodoItem> _todos = [];

  List<TodoItem> get todos => List.unmodifiable(_todos);

  List<TodoItem> get completedTodos => _todos.where((todo) => todo.isCompleted).toList();

  List<TodoItem> get pendingTodos => _todos.where((todo) => !todo.isCompleted).toList();

  int get totalTodos => _todos.length;

  int get completedCount => completedTodos.length;

  int get pendingCount => pendingTodos.length;

  void addTodo(String title, {String description = ''}) {
    final todo = TodoItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index >= 0) {
      _todos[index].isCompleted = !_todos[index].isCompleted;
      _todos[index].completedAt = _todos[index].isCompleted ? DateTime.now() : null;
      notifyListeners();
    }
  }

  void updateTodo(String id, String title, {String description = ''}) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index >= 0) {
      _todos[index].title = title;
      _todos[index].description = description;
      notifyListeners();
    }
  }

  void clearCompleted() {
    _todos.removeWhere((todo) => todo.isCompleted);
    notifyListeners();
  }

  void clearAll() {
    _todos.clear();
    notifyListeners();
  }
}
