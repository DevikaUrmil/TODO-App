import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/ModelClass/TodoModelClass.dart';

class TodoController extends GetxController {
  TextEditingController? titleTxtField = TextEditingController();
  TextEditingController? descriptionTxtField = TextEditingController();

  TextEditingController? minutesTxtField = TextEditingController();
  TextEditingController? secondsTxtField = TextEditingController();

  int minM = 0;
  int maxM = 5;

  int minS = 0;
  int maxS = 59;

  var todos = [].obs;

  var arrItem = [
    "Task 1",
    "Task 2",
    "Task 3",
    "Task 4",
    "Task 5",
  ].obs;

  var arrIcon = [
    //Icons.adjust_rounded,
    Icons.album_rounded,
    Icons.album_rounded,
    Icons.album_rounded,
    Icons.album_rounded,
    Icons.album_rounded,
  ].obs;

  var start = 0.obs;
  Timer? _timer;
  final time = "00.00".obs;

  @override
  void onInit() async {
    getData();
    super.onInit();
  }

  getData() async {
    var box = await Hive.openBox('TODO');
    var items = box.values.toList().reversed.toList();
    print(" items $items");

    items.forEach((item) {
      print(item);
      todos.add(item);
      print(todos);
    });

    print(todos.length);
  }

  deleteData() async {
    var box = await Hive.openBox('TODO');
    //box.delete(todos[index]);
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        start++;
        var i = start.toInt() ~/ 60;
        var j = (start % 60);

        time.value =
            i.toString().padLeft(2, "0") + ":" + j.toString().padLeft(2, "0");
      },
    );
  }

  disposeTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
    //super.dispose();
  }
}

/*void addNewOrder(NewOrder order) {
  final ordersBox = Hive.box('order');
  var lengthBox = Hive.box('order').values;
  if (lengthBox.isEmpty) {
    ordersBox.put(1, order);
    print('the box is empty');
  } else {
    lengthBox.forEach((item) => allorder.add(item.key));
    int lastElement = allorder.last;
    int newElement = lastElement + 1;
    ordersBox.put(newElement, order);
    allorder.clear();
  }
}*/
