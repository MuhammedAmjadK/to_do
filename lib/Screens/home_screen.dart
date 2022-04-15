import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:to_do/Functions/create_todo.dart';
import 'package:to_do/Model/todo_item_model.dart';
import 'package:to_do/Parameters/common_parameters.dart';
import 'package:to_do/Widgets/todo_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffece5dd),
      backgroundColor: const Color(0xFFF7F5ED),
      appBar: AppBar(
        title: const Text(
          "TODO LIST",
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: itemListNotifier,
          builder: (BuildContext context, List<ToDoItem> item, _) {
            return GroupedListView<ToDoItem, String>(
              padding: const EdgeInsets.all(6),
              elements: itemListNotifier.value,
              groupBy: (ToDoItem item) {
                return DateFormat('MMM dd yyyy').format(item.date);
              },
              groupSeparatorBuilder: (String date) {
                return Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    date.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              itemBuilder: (BuildContext context, ToDoItem item) {
                return TodoItemWidget(
                  item: item,
                );
              },
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectedDate = null;
          selectedTime = null;
          createToDo(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
