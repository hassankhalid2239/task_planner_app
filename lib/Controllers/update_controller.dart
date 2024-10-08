import 'package:get/get.dart';
import 'package:task_planner_app/Modals/task_model.dart';

class UpdateController extends GetxController{
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
    currentDate.value = '$hourIn12HourFormat:${minute.toString().padLeft(2, '0')} $period';
  }


  void splitTimeString(String timeString) {
    List<String> timeParts = timeString.split(" ");
    List<String> hoursAndMinutes = timeParts[0].split(":");

    // String hours = hoursAndMinutes[0];
    // String minutes = hoursAndMinutes[1];
    // String period = timeParts[1];
    hour.value= int.parse(hoursAndMinutes[0]);
    minute.value= int.parse(hoursAndMinutes[1]);
    period.value=timeParts[1];
    if(period.value=='am'){
      currentIndex.value=0;
    }else{
      currentIndex.value=1;
    }
  }

  void getData(TaskModel currentTask)async{
    splitTimeString(currentTask.dueTime);
    dueDate.value= currentTask.dueDate;
    selectedDays.value = currentTask.reminderDays;
  }

  void deleteData(TaskModel task)async{
    task.delete();
  }
}