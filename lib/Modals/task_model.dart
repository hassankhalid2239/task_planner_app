

import 'package:hive/hive.dart';
part 'task_model.g.dart';
@HiveType(typeId: 0)
class TaskModel extends HiveObject{
  @HiveField(0)
  String title;
  @HiveField(1)
  bool isCompleted;
  @HiveField(2)
  String until;
  @HiveField(3)
  List reminderDays;
  @HiveField(4)
  String createdDate;
  @HiveField(5)
  String dueTime;
  @HiveField(6)
  String dueDate;

  TaskModel({
    required this.title,
    required this.isCompleted,
    required this.until,
    required this.reminderDays,
    required this.createdDate,
    required this.dueTime,
    required this.dueDate,
  });
}



// flutter packages pub run build_runner build