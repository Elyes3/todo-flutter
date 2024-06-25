import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoflutter/components/item.dart';
import 'package:todoflutter/providers/todosfilter.dart';
import 'package:todoflutter/providers/todosnotifier.dart';
import 'package:todoflutter/todos/todo_model.dart';

final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todosFilter);
  final todos = ref.watch(todosNotifierProvider).value!;
  switch (filter) {
    case TodosFilter.all:
      return todos;
    case TodosFilter.completed:
      return [...todos.where((Todo t) => t.completed == true)];
    case TodosFilter.uncompleted:
      return [...todos.where((Todo t) => t.completed == false)];
  }
});

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredData = ref.watch(filteredTodos);
    final todosAsyncValue = ref.watch(todosNotifierProvider);
    return todosAsyncValue.when(
      data: (todos) {
        return todos.isEmpty ? 
          const Column(crossAxisAlignment: CrossAxisAlignment.center, 
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.folder_off,size: 75,color: Colors.deepPurple,),
            Text("No todos found for this day!",style: TextStyle(fontSize: 20,color: Colors.deepPurple, fontWeight: FontWeight.bold),),
          ],)
         :  ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredData.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return TodoItem(todo: filteredData[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack){
        final snackbar =  SnackBar(content: Text('$error'));
         WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(snackbar));
        return Container();
      }
    );
  }
}
