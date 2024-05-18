import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/Binding.dart';
import 'package:todo/Controllers/TodoController.dart';
import 'package:todo/Controllers/UserController.dart';
import 'package:todo/ModelClass/TodoModelClass.dart';
import 'package:get/get.dart';
import 'package:todo/Controllers/DetailController.dart';
import 'package:todo/View/TodoVC.dart';
import 'package:todo/View/UserVC.dart';

void main() async {
  await Hive.initFlutter();
  Get.lazyPut(() => UserController(), fenix: true);
  Get.lazyPut(() => TodoController(), fenix: true);
  Get.lazyPut(() => DetailController(), fenix: true);

  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(TodoModelClassAdapter());
  await Hive.openBox('TODO');

  runApp(GetMaterialApp(
    home: UserVC(),
    debugShowCheckedModeBanner: false,
    initialBinding: Binding(),
    title: 'TODO',
    getPages: [
      GetPage(
          name: "/user",
          page: () => UserVC(),
          binding: Binding(),
          children: [
            GetPage(
              name: '/todo',
              page: () => TodoVC(),
              binding: TodoBinding(),
              // transition: Transition.leftToRightWithFade,
              // transitionDuration: Duration(milliseconds: 500),
            ),
            // GetPage(
            //   name: '/detail',
            //   page: () => DetailVC(),
            //   binding: DetailBinding(),
            // ),
          ]),
    ],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
