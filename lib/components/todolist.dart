import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoflutter/components/item.dart';
import 'package:todoflutter/providers/todosnotifier.dart';

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsyncValue = ref.watch(todosNotifierProvider);
    return todosAsyncValue.when(
      data: (todos) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: todos.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return TodoItem(todo: todos[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
