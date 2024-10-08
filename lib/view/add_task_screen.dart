// ignore_for_file: deprecated_member_use
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:task_planner_app/Modals/task_model.dart';
import 'package:task_planner_app/constants.dart';

import '../Controllers/state_controller.dart';
import 'Widgets/custom_textformfield.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _stateController = Get.put(StateController());
  final titleTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stateController.convertTo12HourFormat();
  }
  @override
  Widget build(BuildContext context) {
    DateTime dt= DateTime.now();
    DateTime cDate = DateTime(
      dt.year,
      dt.month,
      dt.day + 1,
    );
    print(DateFormat('E, d MMM yyyy').format(cDate));
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
                    Obx((){
                      return NumberPicker(
                          minValue: 1,
                          maxValue: 12,
                          value: _stateController.hour.value,
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
                            _stateController.hour.value = value;
                          });
                    }),
                    Text(
                      ':',
                      style: TextStyle(
                          color: Color(0xff6368D9),
                          fontWeight: FontWeight.bold,
                          fontSize: 38),
                    ),
                    Obx((){
                      return NumberPicker(
                          minValue: 0,
                          maxValue: 59,
                          value: _stateController.minute.value,
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
                            _stateController.minute.value = value;
                          });
                    }),
                    SizedBox(height: 200,
                      width: 80,
                      child: Obx((){
                        return CarouselSlider(
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.vertical,
                            initialPage: _stateController.currentIndex.value,
                            onPageChanged: (index, reason) {
                              _stateController.currentIndex.value = index;
                              if(index==0){
                                _stateController.period.value='am';
                              }else{
                                _stateController.period.value='pm';
                              }
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
                        );
                      }),
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
                      leading: Obx((){
                        if(_stateController.dueDate.isNotEmpty){
                          return Text(_stateController.dueDate.value,style: TextStyle(color: Colors.black,fontSize: 14),);
                        }else if(_stateController.selectedDays.isNotEmpty){
                          String daysString = _stateController.selectedDays.join(',');
                          if(_stateController.selectedDays.length==7){
                            return Text('Everyday',style: TextStyle(color: Colors.black,fontSize: 14),);
                          }else{
                            return Text('Every $daysString',style: TextStyle(color: Colors.black,fontSize: 14),);
                          }
                        }else{
                          return Text('Today',style: TextStyle(color: Colors.black,fontSize: 14),);
                        }
                      }),
                      trailing: IconButton(onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                            builder: (context, child) => child!,
                            context: context,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          if(pickedDate.isAfter(DateTime.now())){
                            _stateController.dueDate.value=DateFormat('E, d MMM yyyy').format(pickedDate);
                            _stateController.selectedDays.clear();
                          }else{
                            Get.snackbar('Oh!', 'Please Select upcoming date');
                          }

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
                            padding: EdgeInsets.only(right: 17),
                            child: SizedBox(
                              height: 35,
                              width: 35,
                              child: Obx((){
                                return TextButton(
                                    onPressed: (){
                                        if (_stateController.selectedDays
                                            .contains(days[index])) {
                                          _stateController.selectedDays.remove(
                                              days[index]);
                                        } else {
                                          _stateController.selectedDays.add(
                                              days[index]);
                                        }
                                        _stateController.dueDate.value='';
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(_stateController.selectedDays.contains(days[index])?Colors.grey.shade200:Colors.transparent),
                                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                                      shape: WidgetStatePropertyAll(CircleBorder()),
                                    ),
                                    child: Text(days[index],style: TextStyle(color: _stateController.selectedDays.contains(days[index])?Color(0xff6368D9):Colors.grey,fontWeight: FontWeight.w600,fontSize: 13)));
                              }),
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
                  ],
                )
              ),
              Text('${DateTime.now().hour}:${DateTime.now().minute}',style:TextStyle(color: Colors.black)),
              Obx((){
                return Text('${_stateController.hour.value}:${_stateController.minute.value} ${_stateController.period.value}',style:TextStyle(color: Colors.black));
              }),
              Obx((){
                return Text(_stateController.currentDate.value,style:TextStyle(color: Colors.black));
              })
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
                  if(titleTextController.text.isNotEmpty){
                    if(_stateController.selectedDays.isEmpty&&_stateController.dueDate.isEmpty){
                      _stateController.dueDate.value=DateFormat('E, d MMM yyyy').format(DateTime.now());
                    }
                    _stateController.saveTask(titleTextController.text);
                    Navigator.pop(context);
                  }else{
                    Get.snackbar(
                      'Required',
                      'Title is required !',
                      backgroundColor: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 1),
                      icon: const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.red,
                      ),
                      colorText: Colors.pinkAccent,
                    );
                  }

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
    if (titleTextController.text.isNotEmpty ) {
      //add task
      // await _addTaskToDb();
      // _taskController.getTasks();
      Get.back();
    } else if (titleTextController.text.isEmpty) {
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


