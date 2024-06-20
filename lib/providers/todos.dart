import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoflutter/models/todo.dart';
import 'package:todoflutter/utils/date.dart';

const List<Todo> todos = [];

final todosProvider = Provider(
  (ref){
    return todos;
  }
);
final todosOfSelectedDayProvider = Provider.family<List<Todo>,DateTime>((ref, d){
  return todos.where((todo) => isDateEqual(todo.date, d)).toList();
});
