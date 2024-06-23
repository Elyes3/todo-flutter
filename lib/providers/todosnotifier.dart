import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoflutter/models/result.dart';
import 'package:todoflutter/todos/todo_model.dart';
import 'package:todoflutter/todos/todos_service.dart';

TodosService todosService = TodosService();

class TodoNotifier extends AsyncNotifier<List<Todo>> {

  // immutability
  getTodos(int millis) async {
    state = const AsyncValue.loading();
    Result<List<Todo>> res = await todosService.getTodos(millis);
    List<Todo> todos = res.data!;
    state = AsyncValue.data(todos);
  }

  createTodo(Todo todo) async {
    state = const AsyncValue.loading();
    Result<Todo> res = await todosService.createTodo(todo);
    Todo createdTodo = res.data!;
    List<Todo> todos = state.value!;
    state = AsyncValue.data(
        [...todos.where((Todo t) => t.id != todo.id), createdTodo]);    
  }

  updateTodo(Todo todo) async {
    state = const AsyncValue.loading();
    Result<Todo> res = await todosService.updateTodo(todo);
    Todo updatedTodo = res.data!;
    List<Todo> todos = state.value!;
    state = AsyncValue.data(
        [...todos.where((Todo t) => t.id != todo.id), updatedTodo]);
  }
  completeTodo(Todo todo) async {
    state = const AsyncValue.loading();
    Result<Todo> res = await todosService.completeTodo(todo);
    Todo updatedTodo = res.data!;
    List<Todo> todos = state.value!;
    state = AsyncValue.data(
        [...todos.where((Todo t) => t.id != todo.id), updatedTodo]);
  }
  deleteTodo(Todo todo) async {
    state = const AsyncValue.loading();
    await todosService.deleteTodo(todo);
    List<Todo> todos = state.value!;
    state = AsyncValue.data([...todos.where((Todo t) => t.id != todo.id)]);
  }

  @override
  Future<List<Todo>> build() async {
    return [];
  }
}

final todosNotifierProvider =
    AsyncNotifierProvider<TodoNotifier, List<Todo>>(() {
  return TodoNotifier();
});
