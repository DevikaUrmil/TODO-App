import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Reusable/Reusable.dart';
import 'package:todo/View/TodoVC.dart';
import 'package:todo/Controllers/UserController.dart';

class UserVC extends GetView<UserController> {
  UserVC({Key? key}) : super(key: key);

  var controller1 = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Reusable.appBar(Text("Christine")),
      body: SafeArea(
        minimum: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(180),
                    child: Image.asset("assets/profile.png"),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "App world Infotech",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Application Developer",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    title: "Task List",
                    context: context,
                    onTap: () {
                      Get.to(() => TodoVC());
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
