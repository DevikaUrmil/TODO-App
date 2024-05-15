import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Reusable/Reusable.dart';
import 'package:todo/View/DetailVC.dart';
import 'package:todo/View/TodoController.dart';
import 'package:todo/Global/Constant.dart';
import 'package:flutter/material.dart';

class TodoVC extends GetView<TodoController> {
  TodoVC({Key? key}) : super(key: key);

  var controller1 = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: listView(),
        ),
      ),
    );
  }

  Widget listView() {
    return SizedBox(
      height: MediaQuery.of(Get.context!).size.height - 20,
      child: ListView.separated(
        itemCount: controller1.arrItem.length,
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 15);
        },
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            // if (index == 0) {
            //   Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => const EditProfileVC()),
            //   );
            // }
            //else
            if (index == 0) {
            } else if (index == 1) {
              //_launchURL("https://www.tirecloud.com/privacy-policy");
            } else if (index == 2) {
              //_launchURL("https://www.tirecloud.com/terms-of-service");
            } else if (index == 3) {
              showDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Log out?"),
                  content: const Text("Are you sure you want to log out?"),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    CupertinoDialogAction(
                      textStyle: const TextStyle(color: Colors.red),
                      isDefaultAction: true,
                      onPressed: () async {
                        Navigator.pop(context);
                        //_callLgout();
                      },
                      child: const Text("Log out"),
                    ),
                  ],
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Icon(
                              controller1.arrIcon[index],
                              size: 18,
                              color: Palette.appColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Text(
                                  controller1.arrItem[index],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // const SizedBox(height: 2),
                              Text("Description"),
                              //const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text("Status :"),
                                  const SizedBox(width: 10),
                                  Text("Created")
                                ],
                              ),
                              Row(
                                children: [
                                  AppButton(
                                    context: Get.context,
                                    height: 20,
                                    width: 50,
                                    txtSize: 13,
                                    onTap: () {
                                      // controller1.startTimer();
                                      controller1.stopwatch = Stopwatch();
                                      controller1.t = Timer.periodic(
                                          Duration(milliseconds: 30),
                                          (timer) {});
                                      controller1.handleStartStop();
                                    },
                                    title: "start",
                                  ),
                                  const SizedBox(width: 10),
                                  Obx(() => Text(
                                        controller1.out.toString(),
                                      )),
                                  const SizedBox(width: 10),
                                  AppButton(
                                    context: Get.context,
                                    height: 20,
                                    width: 50,
                                    txtSize: 13,
                                    onTap: () {
                                      // controller1.dispose();
                                      controller1.handleStartStop();
                                    },
                                    title: "stop",
                                  ),
                                  AppButton(
                                    title: "Delete",
                                    context: Get.context,
                                    bgColor: Colors.red,
                                    height: 20,
                                    width: 50,
                                    txtSize: 13,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_right,
                                color: Palette.appColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
