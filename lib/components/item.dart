import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String todo;
  const TodoItem({super.key , required this.todo });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget> [
      Text(todo),
       ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.red)
        ),
        onPressed: (){
        // TODO : deleteTodo()
      }, child: const Icon(Icons.delete,color: Colors.white))
      
    ],);
  }
}