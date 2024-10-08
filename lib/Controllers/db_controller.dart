import 'package:get/get.dart';
import 'package:task_planner_app/Controllers/state_controller.dart';

import '../DB/boxes.dart';
import '../Modals/task_model.dart';

class DbController extends GetxController{

  void  submitTask(TaskModel task)async{
    final box = Boxes.getRecords();
    box.add(task);
    task.save();
  }


}