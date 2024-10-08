// ignore_for_file: deprecated_member_use
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:task_planner_app/Modals/task_model.dart';
import 'package:task_planner_app/constants.dart';

import '../Controllers/state_controller.dart';
import '../Controllers/update_controller.dart';
import 'Widgets/custom_textformfield.dart';

class UpdateTaskScreen extends StatefulWidget {
  final TaskModel currentTask;
  const UpdateTaskScreen({super.key, required this.currentTask});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final _updateController = Get.put(UpdateController());
  final titleTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateController.convertTo12HourFormat();
    _updateController.getData(widget.currentTask);
  }
  @override
  Widget build(BuildContext context) {

    print(widget.currentTask.dueTime);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        foregroundColor: Theme.of(context).colorScheme.scrim,
        title: Text(
          'Update Task',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(onPressed: (){
            _updateController.deleteData(widget.currentTask);
            Navigator.pop(context);
          }, icon: Icon(Icons.delete_outline_sharp,)),
          SizedBox(width: 10,)
        ],
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
                        value: _updateController.hour.value,
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
                          _updateController.hour.value = value;
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
                        value: _updateController.minute.value,
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
                          _updateController.minute.value = value;
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
                          initialPage: _updateController.currentIndex.value,
                          onPageChanged: (index, reason) {
                            _updateController.currentIndex.value = index;
                            if(index==0){
                              _updateController.period.value='am';
                            }else{
                              _updateController.period.value='pm';
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
                        if(_updateController.dueDate.isNotEmpty){
                          return Text(_updateController.dueDate.value,style: TextStyle(color: Colors.black,fontSize: 14),);
                        }else if(_updateController.selectedDays.isNotEmpty){
                          String daysString = _updateController.selectedDays.join(',');
                          if(_updateController.selectedDays.length==7){
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
                            _updateController.dueDate.value=DateFormat('E, d MMM yyyy').format(pickedDate);
                            _updateController.selectedDays.clear();
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
                                      _updateController.dueDate.value='';
                                      if(_updateController.selectedDays.contains(days[index])){
                                        _updateController.selectedDays.remove(days[index]);

                                      }else{
                                        _updateController.selectedDays.add(days[index]);
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(_updateController.selectedDays.contains(days[index])?Colors.grey.shade200:Colors.transparent),
                                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                                      shape: WidgetStatePropertyAll(CircleBorder()),
                                    ),
                                    child: Text(days[index],style: TextStyle(color: _updateController.selectedDays.contains(days[index])?Color(0xff6368D9):Colors.grey,fontWeight: FontWeight.w600,fontSize: 13)));
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
            Obx((){
              return Text('${_updateController.hour.value}:${_updateController.minute.value} ${_updateController.period.value}',style:TextStyle(color: Colors.black));
            }),

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
                    if(_updateController.selectedDays.isEmpty&&_updateController.dueDate.isEmpty){
                      _updateController.dueDate.value=DateFormat('E, d MMM yyyy').format(DateTime.now());
                    }
                    // _updateController.saveTask(titleTextController.text);
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
}


