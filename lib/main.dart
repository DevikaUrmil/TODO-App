import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/Binding.dart';
//import 'package:hive_generator/hive_generator.dart';
//import 'package:build_runner/build_runner.dart';
import 'package:todo/ModelClass/TodoModelClass.dart';
import 'package:get/get.dart';
import 'package:todo/View/DetailController.dart';
import 'package:todo/View/DetailVC.dart';
import 'package:todo/View/TodoController.dart';
import 'package:todo/View/TodoVC.dart';
import 'package:todo/View/UserController.dart';
import 'package:todo/View/UserVC.dart';

void main() async {
  await Hive.initFlutter();
  Get.lazyPut(() => UserController(), fenix: true);
  Get.lazyPut(() => TodoController(), fenix: true);
  Get.lazyPut(() => DetailController(), fenix: true);

  Hive.registerAdapter(TodoModelClassAdapter());

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
            GetPage(
              name: '/detail',
              page: () => DetailVC(),
              binding: DetailBinding(),
            ),
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Box<TodoModelClass>? todoBox;

  void _incrementCounter() {
    Hive.openBox<TodoModelClass>('Todo');
    todoBox = Hive.box<TodoModelClass>('Todo');

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FloatingActionButton(
              onPressed: () {
                Box<TodoModelClass> todoBox = Hive.box<TodoModelClass>('Todo');
                print(todoBox);
              },
              tooltip: "Get",
              child: Text("Get"),
            ),
            FloatingActionButton(
              onPressed: () async {
                var todoModel = TodoModelClass(
                    "title", "description", "status", 1); //creating object
                await todoBox?.put(
                    todoModel.title, todoModel); //putting object into hive box
              },
              tooltip: "add",
              child: Text("Add"),
            ),
            FloatingActionButton(
              onPressed: () {
                TodoModelClass? todoModel = todoBox?.get('foo'); //get by key
                TodoModelClass? catModel = todoBox?.getAt(3); //get by index
                List<TodoModelClass>? catModelList =
                    todoBox?.values.toList(); //get all items in list

                print(todoModel);
                print(catModel);
                print(catModelList);
              },
              tooltip: "read",
              child: Text("Read"),
            ),
            FloatingActionButton(
              onPressed: () async {
                var catModel = TodoModelClass(
                    "title", "description", "status", 2); //creating new object
                await todoBox?.put(
                    catModel.title, catModel); //putting object into hive box
              },
              tooltip: "Update",
              child: Text("Update"),
            ),
            FloatingActionButton(
              onPressed: () async {
                // Box<TodoModelClass> catBox =
                //     await HiveBoxHelperClass.openCatBox();
                await todoBox!
                    .delete('foo'); //delete cat with key (name) as 'foo'
              },
              tooltip: "Delete",
              child: Text("Delete"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
