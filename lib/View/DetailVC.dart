import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Controllers/DetailController.dart';
import 'package:todo/Global/Constant.dart';
import 'package:todo/ModelClass/TodoModelClass.dart';
import 'package:todo/Reusable/Reusable.dart';
import 'package:todo/Controllers/TodoController.dart';

class DetailVC extends GetView<DetailController> {
  TodoModelClass? objTodo;
  DetailVC({Key? key, required this.objTodo}) : super(key: key);

  var controller1 = Get.find<DetailController>();
  var todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Reusable.appBar(Text(objTodo?.title ?? "")),
      body: SafeArea(
        minimum: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Title"),
                const SizedBox(height: 3),
                Text(objTodo?.title ?? ""),
                const SizedBox(height: 10),
                label("Description"),
                const SizedBox(height: 3),
                Text(objTodo?.description ?? ""),
                const SizedBox(height: 10),
                label("Status"),
                const SizedBox(height: 3),
                Text(objTodo?.title ?? ""),
                const SizedBox(height: 10),
                label("Timer"),
                const SizedBox(height: 3),
                Text(
                  "${controller1.getTimeMinutes(objTodo!.time)} : ${controller1.getTimeSeconds(objTodo!.time)}",
                ),
                const SizedBox(height: 30),
                AppButton(
                  title: "Edit",
                  context: Get.context,
                  width: MediaQuery.of(Get.context!).size.width - 20,
                  onTap: () {
                    bottomSheetView();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static label(String title, {Color? txtColor}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: txtColor ?? Colors.black,
      ),
    );
  }

  bottomSheetView() {
    controller1.titleTxtField?.value.text = objTodo?.title ?? "";
    controller1.descriptionTxtField?.value.text = objTodo?.description ?? "";
    controller1.minutesTxtField?.value.text =
        controller1.getTimeMinutes(objTodo!.time).toString();
    controller1.secondsTxtField?.value.text =
        controller1.getTimeSeconds(objTodo!.time).toString();

    return Get.bottomSheet(
      Container(
        width: MediaQuery.of(Get.context!).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Reusable.topLabel("Title"),
                const SizedBox(height: 3),
                TxtFieldWidget(
                  controller: controller1.titleTxtField?.value,
                ),
                const SizedBox(height: 10),
                Reusable.topLabel("Description"),
                const SizedBox(height: 3),
                TxtFieldWidget(
                    controller: controller1.descriptionTxtField?.value),
                const SizedBox(height: 10),
                Reusable.topLabel("Time"),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Minutes"),
                        const SizedBox(height: 3),
                        Container(
                          width:
                              MediaQuery.of(Get.context!).size.width / 2 - 30,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextField(
                            controller: controller1.minutesTxtField?.value,
                            onChanged: (String value) {
                              int x;
                              try {
                                x = int.parse(value);
                              } catch (error) {
                                x = controller1.minM;
                              }
                              if (x < controller1.minM) {
                                x = controller1.minM;
                              } else if (x > controller1.maxM) {
                                x = controller1.maxM;
                              }

                              controller1.minutesTxtField?.value.value =
                                  TextEditingValue(
                                text: x.toString(),
                                selection: TextSelection.fromPosition(
                                  TextPosition(
                                    offset: controller1.minutesTxtField!.value
                                        .selection.baseOffset,
                                  ),
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(fontSize: 15),
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey, fontSize: 15),
                              hintText: "",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Seconds"),
                        const SizedBox(height: 3),
                        Container(
                          width:
                              MediaQuery.of(Get.context!).size.width / 2 - 30,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextField(
                            controller: controller1.secondsTxtField?.value,
                            onChanged: (String value) {
                              int xs;
                              try {
                                xs = int.parse(value);
                              } catch (error) {
                                xs = controller1.minS;
                              }
                              if (xs < controller1.minS) {
                                xs = controller1.minS;
                              } else if (xs > controller1.maxS) {
                                xs = controller1.maxS;
                              }

                              controller1.secondsTxtField?.value.value =
                                  TextEditingValue(
                                text: xs.toString(),
                                selection: TextSelection.fromPosition(
                                  TextPosition(
                                    offset: controller1.minutesTxtField!.value
                                        .selection.baseOffset,
                                  ),
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(fontSize: 15),
                              hintStyle: const TextStyle(
                                  color: Colors.blueGrey, fontSize: 15),
                              hintText: "",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      title: "Pause",
                      context: Get.context,
                      width: MediaQuery.of(Get.context!).size.width / 3 - 20,
                    ),
                    AppButton(
                      title: "Stop",
                      context: Get.context,
                      width: MediaQuery.of(Get.context!).size.width / 3 - 20,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      title: "Save",
                      context: Get.context,
                      onTap: () async {
                        if (controller1.titleTxtField?.value != null &&
                            controller1.descriptionTxtField?.value != null &&
                            controller1.minutesTxtField?.value != null &&
                            controller1.secondsTxtField?.value != null) {
                          await controller1.editData(objTodo!.id);

                          objTodo?.title =
                              controller1.titleTxtField?.value.text ?? "";
                          objTodo?.description =
                              controller1.descriptionTxtField?.value.text ?? "";

                          Get.back();
                          Get.back();

                          todoController.getData();

                          topMsg(Get.context!, "TODO updated successfully", 5,
                              false);

                          controller1.titleTxtField?.value.clear();
                          controller1.descriptionTxtField?.value.clear();
                          controller1.minutesTxtField?.value.clear();
                          controller1.secondsTxtField?.value.clear();
                        } else {}
                      },
                    ),
                    AppButton(
                      title: "Cancel",
                      context: Get.context,
                      onTap: () {
                        controller1.titleTxtField?.value.clear();
                        controller1.descriptionTxtField?.value.clear();
                        controller1.minutesTxtField?.value.clear();
                        controller1.secondsTxtField?.value.clear();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
