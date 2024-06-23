import 'package:todoflutter/models/result.dart';
import 'package:todoflutter/todos/todo_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'dart:core';

class TodosService {
  final String? _baseUrl = dotenv.env['BASE_URL'];
  final String _endpoint = 'todos';
  Future<Result<List<Todo>>> getTodos(int millis) async {
    var url = Uri.parse('$_baseUrl/$_endpoint?millis=$millis');
    print("TEST");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print("200 $data");
      List<Todo> todos = Todo.listFromJson(data);
      return Result(data: todos);
    } else {
      Map<String, dynamic> data = json.decode(response.body);
      return Result(error: data["error"]);
    }
  }

  Future<Result<Todo>> createTodo(Todo todo) async {
    var url = Uri.parse('$_baseUrl/$_endpoint');
    print(url);
    Map<String, dynamic> jsonTodo = todo.toJson();
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonTodo));
    if (response.statusCode == 201) {
      Map<String, dynamic> data = json.decode(response.body);
      Todo todo = Todo.fromJson(data["todo"]);
      return Result(data: todo, message: data["message"]);
    } else {
      Map<String, dynamic> data = json.decode(response.body);
      return Result(error: data["error"]);
    }
  }

  Future<Result<Todo>> updateTodo(Todo todo) async {
    var url = Uri.parse('$_baseUrl/$_endpoint/${todo.id}/description');
    print(url);
    Map<String, dynamic> jsonTodo = todo.toJson();
    var response = await http.patch(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonTodo));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Todo todo = Todo.fromJson(data["todo"]);
      return Result(data: todo, message: data["message"]);
    } else {
      Map<String, dynamic> data = json.decode(response.body);
      return Result(error: data["error"]);
    }
  }

  Future<Result<Todo>> completeTodo(Todo todo) async {
    var url = Uri.parse('$_baseUrl/$_endpoint/${todo.id}/completed');
    print(url);
    Map<String, dynamic> jsonTodo = todo.toJson();
    var response = await http.patch(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonTodo));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Todo todo = Todo.fromJson(data["todo"]);
      return Result(data: todo, message: data["message"]);
    } else {
      Map<String, dynamic> data = json.decode(response.body);
      return Result(error: data["error"]);
    }
  }
  Future<Result<Todo>> deleteTodo(Todo todo) async {
    var url = Uri.parse('$_baseUrl/$_endpoint/${todo.id}');
    print(url);
    var response = await http.delete(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Todo todo = Todo.fromJson(data["todo"]);
      return Result(data: todo, message: data["message"]);
    } else {
      Map<String, dynamic> data = json.decode(response.body);
      return Result(error: data["error"]);
    }
  }
}
