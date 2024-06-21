import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoflutter/components/item.dart';
import 'package:todoflutter/models/todo.dart';
import 'package:todoflutter/providers/todosnotifier.dart';
import 'package:todoflutter/utils/date.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  String _todoDescription = '';
  @override
  initState() {
    super.initState();
    print("initState Called");
    ref
        .read(todosNotifierProvider.notifier)
        .getTodos(getDateTime(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todosNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:
            const Text('Todo Flutter', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: ListView(
              children: <Widget>[
                Row(children: [
                  Expanded(
                      child: SizedBox(
                          height: 40,
                          child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _todoDescription = value;
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
                      if (_todoDescription.isNotEmpty) {
                        Todo todo = Todo(
                            id: '',
                            description: _todoDescription,
                            millis: getDateTime(_focusedDay));
                        ref
                            .read(todosNotifierProvider.notifier)
                            .createTodo(todo);
                        setState(() {
                          _todoDescription = '';
                        });
                      }
                    },
                    child: const Text('Add',
                        style: TextStyle(color: Colors.white)),
                  )
                ]),
                TableCalendar(
                  firstDay: DateTime.utc(2024, 06, 18),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      print(selectedDay);
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                    });

                    int millis = getDateTime(selectedDay);
                    print(millis);
                    ref.read(todosNotifierProvider.notifier).getTodos(millis);
                  },
                ),
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
                ListView.builder(
                  itemCount: todos.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TodoItem(todo: todos[index]);
                  },
                )
              ],
            ),
          )),
    );
  }
}
