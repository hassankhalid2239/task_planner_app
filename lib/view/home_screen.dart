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
        child: Column(
          children: [

          ],
        ),
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





