import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/Functions/db_functions.dart';
import 'package:to_do/Model/todo_item_model.dart';

class TodoItemWidget extends StatefulWidget {
  const TodoItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ToDoItem item;

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: [
        IconButton(
            onPressed: () {
              Database().deleteToDo(widget.item);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ],
      child: Container(
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
              widget.item.title,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Text(
              widget.item.time.format(context),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Checkbox(
              side: const BorderSide(color: Colors.teal, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              value: widget.item.isCompleted,
              onChanged: (value) {
                setState(() {
                  widget.item.isCompleted = !widget.item.isCompleted;
                  Database().updateToDo(widget.item, context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
