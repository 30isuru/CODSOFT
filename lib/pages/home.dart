import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_item.dart';
import '../widgets/update_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('todos');

  final _toDoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: _appBarWidget(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.8,
                vertical: 28.8,
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'ToDo List',
                        style: TextStyle(
                          fontFamily: '',
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: todoCollection.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        var tasks = snapshot.data!.docs
                            .map((doc) => ToDo.fromMap(
                                doc.data() as Map<String, dynamic>, doc.id))
                            .toList();

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: tasks.length,
                          itemBuilder: (context, index) => ToDoItem(
                            todo: tasks[index],
                            onChangeItem: (ToDo toDo) {
                              _updateTaskStatus(
                                  tasks[index].id, toDo.isdone == 1 ? 0 : 1);
                            },
                            onDeleteItem: (String id) {
                              _deleteTask(id);
                            },
                            onUpdateItem: (ToDo toDo) {
                              _onUpdateItem(toDo);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 28.0,
                      right: 10.0,
                      bottom: 20.0,
                    ),
                    child: TextField(
                      controller: _toDoController,
                      decoration: const InputDecoration(
                        hintText: "add a new task",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: () {
                      _onAddItem(_toDoController.text);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _appBarWidget() {
    return AppBar(
      backgroundColor: Colors.green,
      elevation: 0,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('ToDoXpress')],
      ),
    );
  }

  void _onAddItem(String title) async {
    if (title.isNotEmpty) {
      try {
        await todoCollection.add({
          'title': title,
          'isdone': 0,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task added successfully'),
          ),
        );
      } catch (e) {
        print('Error adding task: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a task'),
        ),
      );
    }
    _toDoController.clear();
  }

  void _onUpdateItem(ToDo todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateToDoScreen(todo: todo),
      ),
    ).then((updatedTodo) {
      if (updatedTodo != null) {
        _updateTask(updatedTodo);
      }
    });
  }

  void _updateTask(ToDo updatedTodo) async {
    try {
      await todoCollection.doc(updatedTodo.id).update(updatedTodo.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task updated successfully'),
        ),
      );
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  void _updateTaskStatus(String taskId, int newStatus) async {
    try {
      await todoCollection.doc(taskId).update({'isdone': newStatus});
    } catch (e) {
      print('Error updating task status: $e');
    }
  }

  void _deleteTask(String taskId) async {
    try {
      await todoCollection.doc(taskId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task deleted successfully'),
        ),
      );
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
