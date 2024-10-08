import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:task_planner_app/Modals/task_model.dart';
import 'package:task_planner_app/view/update_task_screen.dart';

import '../Controllers/update_controller.dart';
import '../DB/boxes.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  final _updateController = Get.put(UpdateController());
  @override
  Widget build(BuildContext context) {
    print(_selectedDate);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        // backgroundColor: Color(0xffd9daf3),
        centerTitle: true,
        title: Text(
          DateFormat.yMMMd().format(_selectedDate)==DateFormat.yMMMd().format(DateTime.now())?
          'Today': DateFormat.yMMMd().format(_selectedDate),
          style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: DatePicker(
            DateTime.now(),
            height: 100,
            width: 75,
            initialSelectedDate: DateTime.now(),
            selectionColor: Color(0xff6368D9),
            selectedTextColor: Colors.white,
            dateTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            ),
            dayTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            ),
            monthTextStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            ),
            onDateChange: (date){
              setState(() {
                _selectedDate=date;
              });

            },
          ),
        ),
      ),
      body: ValueListenableBuilder<Box<TaskModel>>(
        valueListenable: Boxes.getRecords().listenable(),
        builder: (context, box, child) {
          var data = box.values.toList().cast<TaskModel>();
          return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child:  data.isNotEmpty?
              ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 50),
                itemCount: box.length,
                // itemCount: 10,
                itemBuilder: (context, index) {
                    String daysString;
                    if(data[index].dueDate.isEmpty){
                      daysString = data[index].reminderDays.join(',');
                    }else{
                      daysString = '';
                    }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child:  Dismissible(
                        // background: Container(color: Colors.red,),
                        key: Key(data[index].title),
                        onDismissed: (direction) {
                          _updateController.deleteData(data[index]);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          // color: Theme.of(context).colorScheme.onSecondary,
                          color: data[index].isCompleted
                              ? Color(0xff989cff)
                              : Color(0xff767eff),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            splashFactory: InkRipple.splashFactory,
                            splashColor: Color(0xff6368D9),
                            overlayColor:
                            const WidgetStatePropertyAll(Color(0xff6368D9)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateTaskScreen(
                                        currentTask: data[index],
                                      )));
                            },
                            child: ListTile(
                                title: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  data[index].title,
                                  // 'Task $index',
                                  style: TextStyle(
                                      color: data[index].isCompleted?Colors.white70:Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                subtitle:Text(
                                  data[index].dueDate.isNotEmpty?
                                  data[index].dueDate:
                                  daysString,
                                  // 'Due date: 1 Sep, 2021',
                                  style: TextStyle(
                                      color: data[index].isCompleted?Colors.
                                      white70:Colors.white, fontSize: 12),
                                ),
                                // subtitle: Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       maxLines: 1,
                                //       overflow: TextOverflow.ellipsis,
                                //       'Use Tensor flow and Computer Vision to build object reorganization apps build with flutter',
                                //       // 'This is description of task This is description of task This is description of task This is description of task This is description of task$index',
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //     const SizedBox(
                                //       height: 10,
                                //     ),
                                //     Text(
                                //       'Due date: ${DateFormat('EEE, d MMMM').format(DateTime.now())}',
                                //       // 'Due date: 1 Sep, 2021',
                                //       style: TextStyle(
                                //           color: Colors.white, fontSize: 12),
                                //     ),
                                //   ],
                                // ),
                                leading: data[index].isCompleted?
                                GestureDetector(
                                    onTap: () {
                                      if(data[index].isCompleted==false){
                                        data[index].isCompleted=true;
                                        data[index].save();
                                      }else{
                                        data[index].isCompleted=false;
                                        data[index].save();
                                      }
                                      // _taskController.markTaskCompleted(
                                      //     int.parse(_taskController
                                      //         .taskList[index].id
                                      //         .toString()),
                                      //     false.toString());
                                      // _taskController.getTasks();
                                    },
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                ):
                                GestureDetector(
                                    onTap: () {
                                      if(data[index].isCompleted==false){
                                        data[index].isCompleted=true;
                                        data[index].save();
                                      }else{
                                        data[index].isCompleted=false;
                                        data[index].save();
                                      }
                                      // _taskController.markTaskCompleted(
                                      //     int.parse(_taskController
                                      //         .taskList[index].id
                                      //         .toString()),
                                      //     true.toString());
                                      // _taskController.getTasks();
                                    },
                                    child: const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.white,
                                      size: 30,
                                    ))
                              // trailing:index%2==0? Icon(Icons.check_circle_outline,color: Color(0xffB3B7EE),) : Icon(Icons.check_circle,color: Color(0xffB3B7EE),)
                            ),
                          ),
                        ),
                      )
                  );
                },
              ):
              Center(
                child: Text(
                  "There's no task!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              )
          );
        },
      ),
      floatingActionButton: SizedBox.fromSize(
        size: const Size.square(60),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()));
          },
          // shape: const CircleBorder(),
          // backgroundColor: Theme.of(context).colorScheme.onSecondary,
          backgroundColor: const Color(0xff6368D9),
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}





