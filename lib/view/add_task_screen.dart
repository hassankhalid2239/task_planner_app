// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  final dueDateTextController = TextEditingController(
      text: DateFormat('EEE, d MMMM, yyyy').format(DateTime.now()));
  final bool isCompleted = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleTextController.dispose();
    descriptionTextController.dispose();
    dueDateTextController.dispose();
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
            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomInputField(
                  controller: titleTextController,
                  labelText: 'Title',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInputField(
                  minLines: 1,
                  maxLines: 15,
                  controller: descriptionTextController,
                  labelText: 'Detail',
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: dueDateTextController,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.scrim),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          builder: (context, child) => Theme(
                            data: ThemeData().copyWith(
                                colorScheme: ColorScheme.light(
                                    background: Theme.of(context)
                                        .colorScheme
                                        .background)),
                            child: child!,
                          ),
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        dueDateTextController.text =
                            DateFormat('EEE, d MMMM, yyyy').format(pickedDate);
                      } else {
                        dueDateTextController.text =
                            DateFormat('EEE, d MMMM, yyyy')
                                .format(DateTime.now());
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF2F2F2),
                      labelText: 'Date',
                      labelStyle:TextStyle(
                          color: Theme.of(context).colorScheme.scrim),
                      suffixIcon: Icon(
                        Icons.date_range,
                        color: Theme.of(context).primaryColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.scrim)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.surfaceBright),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: dueDateTextController,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.scrim),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          builder: (context, child) => Theme(
                            data: ThemeData().copyWith(
                                colorScheme: ColorScheme.light(
                                    background: Theme.of(context)
                                        .colorScheme
                                        .background)),
                            child: child!,
                          ),
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        dueDateTextController.text =
                            DateFormat('EEE, d MMMM, yyyy').format(pickedDate);
                      } else {
                        dueDateTextController.text =
                            DateFormat('EEE, d MMMM, yyyy')
                                .format(DateTime.now());
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF2F2F2),
                      labelText: 'Time',
                      labelStyle:TextStyle(
                          color: Theme.of(context).colorScheme.scrim),
                      suffixIcon: Icon(
                        Icons.access_time_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.scrim)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.surfaceBright),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                        backgroundColor: WidgetStatePropertyAll(
                            Color(0xff6368D9))),
                    onPressed: () {
                      submitData();
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
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
