import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String id;
  String title;
  int isdone;

  ToDo({required this.id, required this.title, this.isdone = 0});

  factory ToDo.fromMap(Map<String, dynamic> map, String documentId) {
    return ToDo(
      id: documentId,
      title: map['title'] ?? '',
      isdone: map['isdone'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isdone': isdone,
    };
  }

  Future<void> saveToFirestore() async {
    try {
      await FirebaseFirestore.instance
          .collection('todos')
          .doc(id)
          .update(toMap());
    } catch (error) {
      print('Error saving task: $error');
    }
  }

  static Stream<List<ToDo>> todoListStream() {
    return FirebaseFirestore.instance
        .collection('todos')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ToDo.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  static Future<void> addTaskToFirestore(String title) async {
    try {
      await FirebaseFirestore.instance.collection('todos').add({
        'title': title,
        'isdone': 0,
      });
    } catch (error) {
      print('Error adding task: $error');
    }
  }

  static Future<void> updateTaskInFirestore(ToDo updatedToDo) async {
    try {
      await FirebaseFirestore.instance
          .collection('todos')
          .doc(updatedToDo.id)
          .update({
        'title': updatedToDo.title,
        'isdone': updatedToDo.isdone,
      });
    } catch (error) {
      print('Error updating task: $error');
    }
  }

  Future<void> deleteFromFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('todos').doc(id).delete();
    } catch (error) {
      print('Error deleting task: $error');
    }
  }
}
