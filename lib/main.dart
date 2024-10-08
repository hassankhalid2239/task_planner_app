import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_planner_app/Modals/task_model.dart';
import 'package:task_planner_app/view/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var directory= await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('Tasks');
  runApp(const MyApp());
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