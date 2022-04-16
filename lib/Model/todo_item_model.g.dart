// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoItem _$ToDoItemFromJson(Map<String, dynamic> json) => ToDoItem(
      id: json['id'] as String?,
      date: DateTime.parse(json['date'] as String),
      time: TimeOfDay(
          hour: int.parse((json['time'] as String).split(':')[0]),
          minute: int.parse((json['time'] as String).split(':')[1])),
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$ToDoItemToJson(
        ToDoItem instance, BuildContext context) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'time': "${instance.time.hour}:${instance.time.minute}",
      'title': instance.title,
      'isCompleted': instance.isCompleted,
    };
