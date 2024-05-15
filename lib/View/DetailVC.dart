import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/View/DetailController.dart';

class DetailVC extends GetView<DetailController> {
  DetailVC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetX Store"),
      ),
      body: Container(),
    );
  }
}
