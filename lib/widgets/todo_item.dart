import 'package:flutter/material.dart';
import 'package:todo_app/constants/color.dart';

import '../models/todo.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({
    super.key,
    required this.todo,
    required this.onchangeitem,
    required this.ondeleteitem,
    required this.onupdateitem,
  });

  final ToDo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onchangeitem;
  // ignore: prefer_typing_uninitialized_variables
  final ondeleteitem;
  final Function(ToDo) onupdateitem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        onTap: () {
          onchangeitem(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.8),
        ),
        tileColor: todo.isdone == 1 ? Colors.green : Colors.red,
        leading: Container(
          child: Icon(
            todo.isdone == 1 ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.white,
          ),
        ),
        title: Text(
          todo.title,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              color: Colors.black,
              icon: const Icon(
                Icons.update,
                size: 20.0,
              ),
              onPressed: () {
                onupdateitem(todo);
              },
            ),
            Container(
              child: IconButton(
                color: Colors.black,
                icon: const Icon(
                  Icons.delete,
                  size: 20.0,
                ),
                onPressed: () {
                  ondeleteitem(todo.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
