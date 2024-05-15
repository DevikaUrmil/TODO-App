import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class TodoController extends GetxController {
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

  final storeName = 'Thick Shake'.obs;
  // var start = 0.obs;

  // Timer? _timer;

  // void startTimer() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       start++;
  //       var i = start.toInt() ~/ 60;
  //       var j = (start % 60);
  //       print(i);
  //       print(j);
  //     },
  //   );
  // }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }

  late Stopwatch stopwatch;
  late Timer t;
  var out = 0.obs;

  void handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      print(stopwatch.elapsed.inMilliseconds);
    } else {
      stopwatch.start();
      print(stopwatch.elapsed.inMilliseconds);
      var milli = stopwatch.elapsed.inMilliseconds;
      out.value = milli;

      // String milliseconds = (milli % 1000)
      //     .toString()
      //     .padLeft(3, "0"); // this one for the miliseconds
      // String seconds = ((milli ~/ 1000) % 60)
      //     .toString()
      //     .padLeft(2, "0"); // this is for the second
      // String minutes = ((milli ~/ 1000) ~/ 60)
      //     .toString()
      //     .padLeft(2, "0"); // this is for the minute

      // out.value = "$minutes:$seconds:$milliseconds";
      // print(out);
    }
  }
}
