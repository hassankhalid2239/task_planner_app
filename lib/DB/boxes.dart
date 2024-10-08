import 'package:hive/hive.dart';
import 'package:task_planner_app/Modals/task_model.dart';

class Boxes{

  static Box<TaskModel> getRecords()=>Hive.box<TaskModel>('Tasks');
}