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
    bool isCompleted = widget.item.isCompleted;

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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                widget.item.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isCompleted
                      ? Colors.blueGrey.withOpacity(0.5)
                      : Colors.blueGrey,
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(),
            Text(
              widget.item.time.format(context),
              style: TextStyle(
                color:
                    isCompleted ? Colors.black.withOpacity(0.3) : Colors.black,
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
