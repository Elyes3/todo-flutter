import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoflutter/models/result.dart';
import 'package:todoflutter/models/todo.dart';
import 'package:todoflutter/services/todos.service.dart';

TodosService todosService = TodosService();

class TodoNotifier extends Notifier<List<Todo>> {
  // Initial State
  @override
  List<Todo> build() {
    return [];
  }

  getTodos(int millis) async {
    Result<List<Todo>> res = await todosService.getTodos(millis);
    List<Todo> todos = res.data!;
    state = [...todos];
  }

  createTodo(Todo todo) async {
    Result<Todo> res = await todosService.createTodo(todo);
    Todo createdTodo = res.data!;
    state = [...state, createdTodo];
  }

  updateTodo(Todo todo) async {
    Result<Todo> res = await todosService.updateTodo(todo);
    Todo updatedTodo = res.data!;
    state = [...state.where((Todo t) => t.id == todo.id), updatedTodo];
  }

  deleteTodo(Todo todo) async {
    Result<Todo> res = await todosService.deleteTodo(todo);
    state = [...state.where((Todo t) => t.id == todo.id)];
  }
}

final todosNotifierProvider = NotifierProvider<TodoNotifier, List<Todo>>(() {
  return TodoNotifier();
});
