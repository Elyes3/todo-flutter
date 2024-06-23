import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoflutter/todos/todo_model.dart';
import 'package:todoflutter/providers/todosnotifier.dart';

class TodoItem extends ConsumerStatefulWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  @override
  ConsumerState<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends ConsumerState<TodoItem> {
  String _description = '';
  bool _isToggled = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _description = widget.todo.description;
            _isToggled = true;
          });

          print(_isToggled);
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(211, 211, 211, 0.6),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Row(children: <Widget>[
                      Checkbox(
                          value: widget.todo.completed,
                          onChanged: (value) {
                            Todo todo = Todo(
                                description: widget.todo.description,
                                id: widget.todo.id,
                                millis: widget.todo.millis,
                                completed: value!);
                            ref
                                .read(todosNotifierProvider.notifier)
                                .completeTodo(todo);
                          }),
                      !_isToggled
                          ? Text(widget.todo.description)
                          : Expanded(
                              child: SizedBox(
                                  height: 40,
                                  width: 50,
                                  child: TextFormField(
                                    initialValue: widget.todo.description,
                                    onChanged: (value) {
                                      setState(() {
                                        _description = value;
                                      });
                                    },
                                    onTapOutside: (value) {
                                      setState(() {
                                        _isToggled = false;
                                      });
                                      if (_description !=
                                          widget.todo.description) {
                                        Todo updateTodo = Todo(
                                            id: widget.todo.id,
                                            description: _description,
                                            millis: widget.todo.millis,
                                            completed: widget.todo.completed);
                                        ref
                                            .read(
                                                todosNotifierProvider.notifier)
                                            .updateTodo(updateTodo);
                                      }
                                    },
                                  )))
                    ])),
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.red)),
                        onPressed: () async {
                          await ref
                              .read(todosNotifierProvider.notifier)
                              .deleteTodo(widget.todo);
                        },
                        child: const Icon(Icons.delete, color: Colors.white))
                  ],
                ))));
  }
}
