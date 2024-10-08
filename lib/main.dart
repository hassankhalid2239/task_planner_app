import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_planner_app/view/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-do List',
        home:  const SplashScreen(),
    );
  }
}

// flutter packages pub run build_runner build