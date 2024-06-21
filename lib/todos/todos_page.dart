import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoflutter/components/todolist.dart';
import 'package:todoflutter/models/todo.dart';
import 'package:todoflutter/providers/todosnotifier.dart';
import 'package:todoflutter/utils/date.dart';

class TodosPage extends ConsumerStatefulWidget {
  final int millis;
  const TodosPage({super.key, required this.millis});

  @override
  ConsumerState<TodosPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<TodosPage> {
  final TextEditingController _controller = TextEditingController();
  String _todoDescription = '';
  @override
  Widget build(BuildContext context) {
    String date = dateFromMillis(widget.millis);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Todos for $date',
              style: const TextStyle(color: Colors.white)),
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(children: [
              Row(children: [
                Expanded(
                    child: SizedBox(
                        height: 40,
                        child: TextField(
                            controller: _controller,
                            onChanged: (value) {
                              setState(() {
                                _todoDescription = value;
                                print(_todoDescription);
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(0))),
                              labelText: 'Type your todo',
                            )))),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(
                              20)), // Adjust the radius as needed
                    ),
                  ),
                  onPressed: () {
                    print(_todoDescription);
                    if (_todoDescription.isNotEmpty) {
                      _controller.clear();
                      Todo todo = Todo(
                          id: '',
                          description: _todoDescription,
                          millis: widget.millis);
                      print("CLICKED");
                      ref.read(todosNotifierProvider.notifier).createTodo(todo);
                      setState(() {
                        _todoDescription = '';
                      });
                    }
                  },
                  child:
                      const Text('Add', style: TextStyle(color: Colors.white)),
                )
              ]),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Todos',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.deepPurple),
                  )),
              const TodoList()
            ])));
  }
}