import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/Functions/db_functions.dart';
import 'package:to_do/Model/todo_item_model.dart';
import 'package:to_do/Parameters/common_parameters.dart';

createToDo(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  TextEditingController _taskController = TextEditingController();
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF7F5ED),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                10, 20, 10, MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _taskController,
                    onFieldSubmitted: (value) {
                      formKey.currentState!.validate();
                    },
                    validator: (value) {
                      return value!.trim().isNotEmpty
                          ? null
                          : 'Enter a task name';
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter a Task",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          setState(() {});
                        },
                        child: Text(selectedDate != null
                            ? DateFormat('dd-MM-yyyy').format(selectedDate!)
                            : "Select Date"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          selectedTime = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());

                          setState(() {});
                        },
                        child: Text(selectedTime != null
                            ? selectedTime!.format(context)
                            : "Select Time"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ToDoItem todo = ToDoItem(
                          date: selectedDate ?? DateTime.now(),
                          time: selectedTime ?? TimeOfDay.now(),
                          title: _taskController.text,
                        );
                        Database().createTodo(todo, context);
                        itemListNotifier.value.add(todo);

                        itemListNotifier.notifyListeners();
                        Navigator.pop(ctx);
                      }
                    },
                    child: const Text("Save"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
      });
}
