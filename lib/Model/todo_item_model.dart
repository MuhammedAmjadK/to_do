import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'todo_item_model.g.dart';

@JsonSerializable()
class ToDoItem {
  String? id;
  final DateTime date;
  final TimeOfDay time;
  final String title;
  bool isCompleted;

  ToDoItem({
    this.id,
    required this.date,
    required this.time,
    required this.title,
    this.isCompleted = false,
  });
  factory ToDoItem.fromJson(Map<String, dynamic> json) =>
      _$ToDoItemFromJson(json);

  Map<String, dynamic> toJson(BuildContext context) =>
      _$ToDoItemToJson(this, context);
}
