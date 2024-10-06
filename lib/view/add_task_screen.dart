// ignore_for_file: deprecated_member_use
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:task_planner_app/constants.dart';

import 'Widgets/custom_textformfield.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // final _taskController = Get.put(TaskController());
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final date = DateFormat('EEE, d MMMM, yyyy, h:mma').format(DateTime.now());
  final bool isCompleted = false;
  var hour = 1;
  var minute = 0;
  var cdate;
  var dueDate;
  String period = 'am';
  int _currentIndex = 0;

  String convertTo12HourFormat() {
    // Input format: "HH:mm"
    String date= "${DateTime.now().hour}:${DateTime.now().minute}";
    List<String> parts = date.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    // Convert to 12-hour format
    int hourIn12HourFormat = hour % 12 == 0 ? 12 : hour % 12;
    String period = hour >= 12 ? 'pm' : 'am';

    // Format output as "h:mmam/pm"
    return '$hourIn12HourFormat:${minute.toString().padLeft(2, '0')}$period';
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cdate = convertTo12HourFormat();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          foregroundColor: Theme.of(context).colorScheme.scrim,
          title: Text(
            'Add Task',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  // color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    NumberPicker(
                        minValue: 1,
                        maxValue: 12,
                        value: hour,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 120,
                        itemHeight: 80,
                        textStyle: TextStyle(
                            fontSize: 25,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Color(0xff6368D9)),
                        onChanged: (value) {
                          hour = value;
                          setState(() {});
                        }),
                    Text(
                      ':',
                      style: TextStyle(
                          color: Color(0xff6368D9),
                          fontWeight: FontWeight.bold,
                          fontSize: 38),
                    ),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        value: minute,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 120,
                        itemHeight: 80,
                        textStyle: TextStyle(
                            fontSize: 25,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Color(0xff6368D9)),
                        onChanged: (value) {
                          minute = value;
                          setState(() {});
                        }),
                    SizedBox(height: 200,
                      width: 80,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.vertical,
                          initialPage: _currentIndex,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                              if(index==0){
                                period='am';
                              }else{
                                period='pm';
                              }
                            });
                          },
                        ),
                        items: [
                          Text(
                            'am',
                            style: TextStyle(color:Color(0xff6368D9),fontSize: 36, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'pm',
                            style: TextStyle(color:Color(0xff6368D9),fontSize: 36, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15,),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.vertical(top:Radius.circular(12) )
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Text(dueDate!=null?dueDate:'Everyday',style: TextStyle(color: Colors.black,fontSize: 14),),
                      trailing: IconButton(onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                            builder: (context, child) => child!,
                            context: context,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          setState(() {
                            dueDate=DateFormat('EEE, d MMMM').format(pickedDate);
                          });

                        }
                      },
                      icon: Icon(Icons.date_range_sharp,color: Color(0xff6368D9),),),
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 22),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: TextButton(
                                  onPressed: (){},
                                  style: ButtonStyle(
                                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                                      shape: WidgetStatePropertyAll(CircleBorder()),
                                      side: WidgetStatePropertyAll(BorderSide(color: Colors.black,width: 1))
                                  ),
                                  child: Text(days[index],style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600))),
                            ),
                          );
                        },
                      ),
                    ),
                    CustomInputField(
                      controller: titleTextController,
                      hintText: 'Title',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomInputField(
                      minLines: 1,
                      maxLines: 15,
                      controller: descriptionTextController,
                      hintText: 'Detail',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ),
              Text('${DateTime.now().hour}:${DateTime.now().minute}',style:TextStyle(color: Colors.black)),
              Text('${hour}:${minute} ${period}',style:TextStyle(color: Colors.black)),
              Text(cdate,style:TextStyle(color: Colors.black)),
            ],
          ),
            ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                    elevation: WidgetStatePropertyAll(0),
                    backgroundColor:
                    const WidgetStatePropertyAll(Colors.transparent)
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: FittedBox(
                  child: Text(
                    'Cancel',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                    elevation: WidgetStatePropertyAll(0),
                    backgroundColor:
                    const WidgetStatePropertyAll(Colors.transparent)),
                onPressed: () {

                },
                child: FittedBox(
                  child: Text(
                    'Save',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
          );

  }

  void submitData() async {
    if (titleTextController.text.isNotEmpty &&
        descriptionTextController.text.isNotEmpty) {
      //add task
      // await _addTaskToDb();
      // _taskController.getTasks();
      Get.back();
    } else if (titleTextController.text.isEmpty ||
        descriptionTextController.text.isEmpty) {
      Get.snackbar(
        'Required',
        'All fields are required !',
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
        colorText: Colors.pinkAccent,
      );
    }
  }

  // _addTaskToDb() async {
  //   await _taskController.addTask(
  //       task: TaskModel(
  //           title: titleTextController.text,
  //           description: descriptionTextController.text,
  //           date: date,
  //           dueDate: dueDateTextController.text,
  //           isCompleted: isCompleted.toString()));
  //   // print("My id is "+"$value");
  // }
}


