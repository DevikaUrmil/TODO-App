import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Reusable/Reusable.dart';
import 'package:todo/View/DetailVC.dart';
import 'package:todo/Controllers/TodoController.dart';
import 'package:todo/Global/Constant.dart';
import 'package:hive/hive.dart';

class TodoVC extends GetView<TodoController> {
  TodoVC({Key? key}) : super(key: key);

  var controller1 = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              bottomSheetView();
            },
            icon: const Icon(Icons.add),
          )
        ],
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

  bottomSheetView() {
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
                  controller: controller1.descriptionTxtField?.value,
                ),
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
                          await controller1.addData();
                          Get.back();
                          controller1.todos.clear();
                          await controller1.getData();

                          topMsg(Get.context!, "TODO added successfully", 5,
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

  Widget listView() {
    return SizedBox(
      height: MediaQuery.of(Get.context!).size.height - 20,
      child: Obx(
        () => ListView.separated(
          itemCount: controller1.todos.length,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 15);
          },
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Get.to(DetailVC(objTodo: controller1.todos[index]));
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
                            Icon(
                              Icons.album_rounded,
                              size: 18,
                              color: Palette.appColor,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller1.todos[index].title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(Get.context!).size.width -
                                          150,
                                  child: Text(
                                    controller1.todos[index].description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text("Status :"),
                                    const SizedBox(width: 10),
                                    Text(controller1.todos[index].status)
                                  ],
                                ),
                                Row(
                                  children: [
                                    AppButton(
                                      context: Get.context,
                                      height: 20,
                                      width: 50,
                                      txtSize: 13,
                                      onTap: () {},
                                      title: "start",
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${controller1.getTimeMinutes(controller1.todos[index].time)} : ${controller1.getTimeSeconds(controller1.todos[index].time)}",
                                    ),
                                    const SizedBox(width: 10),
                                    AppButton(
                                      context: Get.context,
                                      height: 20,
                                      width: 50,
                                      txtSize: 13,
                                      onTap: () {
                                        controller1.disposeTimer();
                                      },
                                      title: "stop",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
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
                                ),
                                const Spacer(),
                                AppButton(
                                  title: "Delete",
                                  context: Get.context,
                                  bgColor: Colors.red,
                                  height: 20,
                                  width: 50,
                                  txtSize: 13,
                                  onTap: () async {
                                    print(controller1.todos[index].id);
                                    var box = await Hive.openBox('TODO');
                                    controller1.todos.removeWhere((item) =>
                                        item.id == controller1.todos[index].id);
                                    await box
                                        .delete(controller1.todos[index].id);

                                    // controller1
                                    // .deleteData(controller1.todos[index]);
                                    topMsg(Get.context!,
                                        "TODO deleted successfully", 5, true);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
