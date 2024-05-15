import 'package:flutter/material.dart';
//import 'package:another_flushbar/flushbar.dart';

class Constant {}

class Palette {
  static Color modelManagerBgColor = Colors.white;
  static Color appBarBgColor = Colors.white;
  static Color appColor = Color.fromARGB(255, 175, 149, 192);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

bool emailValidation(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regex = RegExp(pattern);

  if (!(regex.hasMatch(value))) {
    return false;
  } else {
    return true;
  }
}

/*topMsg(BuildContext context, String msg, int duration, bool isError) {
  Flushbar(
    backgroundColor: isError == true ? Colors.red : Colors.green,
    //title: 'Hey Ninja',
    flushbarPosition: FlushbarPosition.TOP,
    message: msg,
    duration: Duration(seconds: duration),
  ).show(context);
}*/
