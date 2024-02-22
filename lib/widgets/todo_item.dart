import 'package:flutter/material.dart';

import '../models/todo.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onChangeItem,
    required this.onDeleteItem,
    required this.onUpdateItem,
  }) : super(key: key);

  final ToDo todo;
  final Function(ToDo) onChangeItem;
  final Function(String) onDeleteItem;
  final Function(ToDo) onUpdateItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        onTap: () {
          onChangeItem(todo);
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
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
                onUpdateItem(todo);
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
                  onDeleteItem(todo.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
