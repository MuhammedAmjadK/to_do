import 'package:flutter/material.dart';
import 'package:to_do/Model/todo_item_model.dart';

DateTime? selectedDate;
TimeOfDay? selectedTime;

ValueNotifier<List<ToDoItem>> itemListNotifier = ValueNotifier([]);
