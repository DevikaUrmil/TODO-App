import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/ModelClass/TodoModelClass.dart';

class TodoController extends GetxController {
  Rx<TextEditingController>? titleTxtField = TextEditingController().obs;
  Rx<TextEditingController>? descriptionTxtField = TextEditingController().obs;
  Rx<TextEditingController>? minutesTxtField = TextEditingController().obs;
  Rx<TextEditingController>? secondsTxtField = TextEditingController().obs;

  int minM = 0;
  int maxM = 5;
  int minS = 0;
  int maxS = 59;

  var todos = [].obs;

  var start = [].obs;
  Timer? _timer;
  final timeString = "00.00".obs;

  @override
  void onInit() async {
    getData();
    super.onInit();
  }

  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  setTime(int minutesT, int secondsT) {
    var timeStamp = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      0, // hours
      minutesT, //minutes
      secondsT, //seconds
    ).millisecondsSinceEpoch;
    return timeStamp;
  }

  getTimeMinutes(int time) {
    var finalv = DateTime.fromMillisecondsSinceEpoch(time);
    return finalv.minute;
  }

  getTimeSeconds(int time) {
    var finalv = DateTime.fromMillisecondsSinceEpoch(time);
    return finalv.second;
  }

  addData() async {
    var box = await Hive.openBox('TODO');
    var timeAdd = setTime(
      int.parse(minutesTxtField?.value.text ?? "0"),
      int.parse(secondsTxtField?.value.text ?? "0"),
    );

    TodoModelClass dataModel = TodoModelClass(
      idGenerator(),
      titleTxtField?.value.text ?? "",
      descriptionTxtField?.value.text ?? "",
      "created",
      timeAdd,
    );
    box.put(dataModel.id, dataModel);
  }

  getData() async {
    var box = await Hive.openBox('TODO');
    var items = box.values.toList().reversed.toList();
    items.forEach((item) {
      todos.add(item);
      start.add(item.time);
    });
  }

  deleteData(String key) async {
    var box = await Hive.openBox('TODO');
    todos.removeWhere((item) => item.id == key);
    await box.delete(key);
  }

  void startTimer(int index) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        start[index]++;
        var i = start[index].toInt() ~/ 60;
        var j = (start[index] % 60);
        timeString.value =
            i.toString().padLeft(2, "0") + ":" + j.toString().padLeft(2, "0");
      },
    );
  }

  disposeTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }
}
