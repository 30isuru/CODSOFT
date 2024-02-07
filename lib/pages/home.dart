import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_item.dart';
import '../widgets/update_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tasks = ToDo.todoList();
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) => ToDoItem(
                        todo: tasks[index],
                        onchangeitem: (ToDo toDo) {
                          setState(() {
                            tasks[index].isdone = toDo.isdone == 1 ? 0 : 1;
                          });
                        },
                        ondeleteitem: (String id) {
                          setState(() {
                            tasks.removeWhere((element) => element.id == id);
                          });
                        },
                        onupdateitem: (ToDo toDo) {
                          _onUpdateItem(toDo);
                        },
                      ),
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
    // appBar: _appBarWidget(),
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

  void _onAddItem(String title) {
    if (title.isNotEmpty) {
      setState(() {
        tasks.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: title,
          isdone: 0,
        ));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('please enter a task'),
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
        int index = tasks.indexWhere((element) => element.id == updatedTodo.id);
        if (index != -1) {
          setState(() {
            tasks[index] = updatedTodo;
          });
        }
      }
    });
  }
}
