import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class UpdateToDoScreen extends StatefulWidget {
  final ToDo todo;

  const UpdateToDoScreen({Key? key, required this.todo}) : super(key: key);

  @override
  _UpdateToDoScreenState createState() => _UpdateToDoScreenState();
}

class _UpdateToDoScreenState extends State<UpdateToDoScreen> {
  late TextEditingController _updateController;

  @override
  void initState() {
    super.initState();
    _updateController = TextEditingController(text: widget.todo.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.green],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: TextField(
                    controller: _updateController,
                    decoration: const InputDecoration(
                      labelText: 'Task Title',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        _onUpdateItem();
                      },
                      child: const Text(
                        'Update Task',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Image.asset("assets/update.png")],
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Update ToDo',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _onUpdateItem() {
    String updatedTitle = _updateController.text.trim();
    if (updatedTitle.isNotEmpty) {
      // Update the title in the local widget.todo
      widget.todo.title = updatedTitle;

      // Save the updated task to Firestore
      widget.todo.saveToFirestore().then((_) {
        Navigator.pop(context);
      }).catchError((error) {
        print('Error updating task: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error updating task. Please try again.'),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a task'),
        ),
      );
    }
  }
}
