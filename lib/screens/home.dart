import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoflutter/components/item.dart';
import 'package:todoflutter/providers/todos.dart';
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
    Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Todo Flutter', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: ListView(
              children: <Widget>[
                Row(children: [
                  const Expanded(
                      child: SizedBox(
                          height: 40,
                          child: TextField(
                              decoration: InputDecoration(
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
                      // TODO : addTodo()
                    },
                    child: const Text('Add',
                        style: TextStyle(color: Colors.white)),
                  )
                ]),
                TableCalendar(
                  firstDay: DateTime.utc(2024, 06, 18),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
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
                    ListView.builder(itemCount: todos.length,
                     scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                     itemBuilder: (context,index){
                      return const TodoItem(todo: 'Some Text');
                    },)
              ],
            ),

          )),
    );
  }
  }