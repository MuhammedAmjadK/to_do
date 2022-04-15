import 'package:flutter/material.dart';

class ToDoItem {
  final DateTime date;
  final TimeOfDay time;
  final String title;
  bool isCompleted;

  ToDoItem({
    required this.date,
    required this.time,
    required this.title,
    this.isCompleted = false,
  });
}
