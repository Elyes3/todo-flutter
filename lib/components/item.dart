import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String todo;
  const TodoItem({super.key , required this.todo });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(211, 211, 211, 0.6),
        borderRadius: BorderRadius.all(Radius.circular(20))),
      child:
      Padding(
      padding:const EdgeInsets.all(10),
      child :Row(  
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
      
    ],)));
  }
}