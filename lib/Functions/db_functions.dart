import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Model/todo_item_model.dart';
import 'package:to_do/Parameters/common_parameters.dart';

class Database extends ChangeNotifier {
  final reference = FirebaseFirestore.instance.collection(userID!);

  createTodo(ToDoItem todo, BuildContext context) async {
    final doc = reference.doc();

    todo.id = doc.id;
    await doc.set(todo.toJson(context));
  }

  updateToDo(ToDoItem todo, BuildContext context) {
    final doc = reference.doc(todo.id);
    doc.update(todo.toJson(context));
  }

  deleteToDo(ToDoItem todo) async {
    final doc = reference.doc(todo.id);
    itemListNotifier.value.removeWhere((item) => item.id == todo.id);
    itemListNotifier.notifyListeners();
    await doc.delete();
  }

  getToDos() async {
    var snapshot = await reference.get();

    itemListNotifier.value.clear();

    for (var element in snapshot.docs) {
      itemListNotifier.value.add(ToDoItem.fromJson(element.data()));
    }
    itemListNotifier.notifyListeners();
  }
}
