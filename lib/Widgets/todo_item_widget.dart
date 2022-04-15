import 'package:flutter/material.dart';
import 'package:to_do/Model/todo_item_model.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ToDoItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.shade400,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            item.title,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            item.time.format(context),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check_circle_rounded,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}
