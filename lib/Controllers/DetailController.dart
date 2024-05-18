import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/ModelClass/TodoModelClass.dart';

class DetailController extends GetxController {
  Rx<TextEditingController>? titleTxtField = TextEditingController().obs;
  Rx<TextEditingController>? descriptionTxtField = TextEditingController().obs;

  Rx<TextEditingController>? minutesTxtField = TextEditingController().obs;
  Rx<TextEditingController>? secondsTxtField = TextEditingController().obs;

  int minM = 0;
  int maxM = 5;

  int minS = 0;
  int maxS = 59;

  Timer? _timer;
  var start = 0.obs;
  final time = "00.00".obs;

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

  updateData() async {
    Box<TodoModelClass> todobox = Hive.box<TodoModelClass>('TODO');

    var todoObj = TodoModelClass("1", "title", "description", "status", 1);
    await todobox.put("id", todoObj);
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
    }
    super.dispose();
  }

  getTimeMinutes(int time) {
    var finalv = DateTime.fromMillisecondsSinceEpoch(time);
    return finalv.minute;
  }

  getTimeSeconds(int time) {
    var finalv = DateTime.fromMillisecondsSinceEpoch(time);
    return finalv.second;
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
    print(timeStamp);
    return timeStamp;
  }

  editData(String key) async {
    var box = await Hive.openBox('TODO');
    print("box : $box");
    var timeAdd = setTime(
      int.parse(minutesTxtField?.value.text ?? "0"),
      int.parse(secondsTxtField?.value.text ?? "0"),
    );

    TodoModelClass dataModel = TodoModelClass(
      key,
      titleTxtField?.value.text ?? "",
      descriptionTxtField?.value.text ?? "",
      "created",
      timeAdd,
    );
    box.put(dataModel.id, dataModel);
  }
}
