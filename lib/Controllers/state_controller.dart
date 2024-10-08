import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:task_planner_app/Modals/task_model.dart';

import '../DB/boxes.dart';
import 'db_controller.dart';

class StateController extends GetxController{
  final _dbController = Get.put(DbController());

  RxInt hour = 1.obs;
  RxInt minute = 0.obs;
  RxString currentDate=''.obs;
  RxString dueDate=''.obs;
  RxString dueTime=''.obs;
  RxString period = 'am'.obs;
  RxInt currentIndex = 0.obs;
  RxList selectedDays = [].obs;

  void convertTo12HourFormat() {
    // Input format: "HH:mm"
    String date= "${DateTime.now().hour}:${DateTime.now().minute}";
    List<String> parts = date.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    // Convert to 12-hour format
    int hourIn12HourFormat = hour % 12 == 0 ? 12 : hour % 12;
    String period = hour >= 12 ? 'pm' : 'am';

    // Format output as "h:mmam/pm"
    currentDate.value = '$hourIn12HourFormat:${minute.toString().padLeft(2, '0')}$period';
  }

  void saveTask(String title){
    String untilTime= '${hour.value}:${minute.value}${period.value}';
    final task = TaskModel(
        title: title,
        isCompleted: false,
        until: '',
        reminderDays: selectedDays,
        createdDate: DateFormat('E, d MMM yyyy').format(DateTime.now()),
        dueTime: untilTime,
        dueDate: dueDate.value);
    _dbController.submitTask(task);
  }




}