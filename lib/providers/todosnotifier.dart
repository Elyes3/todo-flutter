import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoflutter/models/result.dart';
import 'package:todoflutter/models/todo.dart';
import 'package:todoflutter/todos/todos_controller.dart';

TodosController todosController = TodosController();

class TodoNotifier extends AsyncNotifier<List<Todo>> {


  getTodos(int millis) async {
    state = const AsyncValue.loading();
    Result<List<Todo>> res = await todosController.getTodos(millis);
    List<Todo> todos = res.data!;
    state = AsyncValue.data(todos);
  }

  createTodo(Todo todo) async {
    state = const AsyncValue.loading();
    Result<Todo> res = await todosController.createTodo(todo);
    Todo createdTodo = res.data!;
    List<Todo> todos = state.value!;
    state = AsyncValue.data(
        [...todos.where((Todo t) => t.id != todo.id), createdTodo]);    
  }

  updateTodo(Todo todo) async {
    state = const AsyncValue.loading();
    Result<Todo> res = await todosController.updateTodo(todo);
    Todo updatedTodo = res.data!;
    List<Todo> todos = state.value!;
    state = AsyncValue.data(
        [...todos.where((Todo t) => t.id != todo.id), updatedTodo]);
  }

  deleteTodo(Todo todo) async {
    state = const AsyncValue.loading();
    await todosController.deleteTodo(todo);
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
