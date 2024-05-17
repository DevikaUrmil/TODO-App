import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Controllers/DetailController.dart';
import 'package:todo/Reusable/Reusable.dart';

class DetailVC extends GetView<DetailController> {
  DetailVC({Key? key}) : super(key: key);

  var controller1 = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Reusable.appBar(Text("Task 1")),
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
                Text("Task 1"),
                const SizedBox(height: 10),
                label("Description"),
                const SizedBox(height: 3),
                Text("Description"),
                const SizedBox(height: 10),
                label("Status"),
                const SizedBox(height: 3),
                Text("Created"),
                const SizedBox(height: 10),
                label("Timer"),
                const SizedBox(height: 3),
                Obx(
                  () => Text(
                    controller1.time.value,
                  ),
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
                TxtFieldWidget(),
                const SizedBox(height: 10),
                Reusable.topLabel("Description"),
                const SizedBox(height: 3),
                TxtFieldWidget(),
                const SizedBox(height: 10),
                Reusable.topLabel("Time"),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Minutes"),
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
                            controller: controller1.minutesTxtField,
                            onChanged: (String value) {
                              print('Changed');
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

                              controller1.minutesTxtField.value =
                                  TextEditingValue(
                                text: x.toString(),
                                selection: TextSelection.fromPosition(
                                  TextPosition(
                                    offset: controller1.minutesTxtField.value
                                        .selection.baseOffset,
                                  ),
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              //errorText: errorText,

                              labelStyle: const TextStyle(fontSize: 15),
                              //labelText: label,
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
                              // errorBorder: errorrTextFieldBorder(),
                              // focusedErrorBorder: errorrTextFieldBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Seconds"),
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
                            controller: controller1.secondsTxtField,
                            onChanged: (String value) {
                              print('Changed');
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

                              controller1.secondsTxtField.value =
                                  TextEditingValue(
                                text: xs.toString(),
                                selection: TextSelection.fromPosition(
                                  TextPosition(
                                    offset: controller1.minutesTxtField.value
                                        .selection.baseOffset,
                                  ),
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              //errorText: errorText,

                              labelStyle: const TextStyle(fontSize: 15),
                              //labelText: label,
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
                              // errorBorder: errorrTextFieldBorder(),
                              // focusedErrorBorder: errorrTextFieldBorder(),
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
                    // AppButton(
                    //   title: "Play",
                    //   context: Get.context,
                    //   width: MediaQuery.of(Get.context!).size.width / 3 - 20,
                    // ),
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
                    AppButton(title: "Save", context: Get.context),
                    AppButton(title: "Cancel", context: Get.context),
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
