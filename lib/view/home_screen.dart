import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 50),
          itemCount: 8,
          // itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                // color: Theme.of(context).colorScheme.onSecondary,
                color: index%2==0
                    ? Color(0xff989cff)
                    : Color(0xff767eff),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  splashFactory: InkRipple.splashFactory,
                  splashColor: Colors.redAccent,
                  overlayColor:
                  const WidgetStatePropertyAll(Colors.redAccent),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => TaskDetailScreen(
                    //           task: _taskController.taskList[index],
                    //         )));
                  },
                  child: ListTile(
                      title: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        'Build Ai Apps with Flutter',
                        // 'Task $index',
                        style: TextStyle(
                          color: index%2==0?Colors.white70:Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle:Text(
                        '${DateFormat('EEE, d MMMM').format(DateTime.now())}',
                        // 'Due date: 1 Sep, 2021',
                        style: TextStyle(
                            color: index%2==0?Colors.
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
                      leading: index%2==0?
                      GestureDetector(
                          onTap: () {
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
                          )):
                      GestureDetector(
                          onTap: () {
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
            );
          },
        )
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





