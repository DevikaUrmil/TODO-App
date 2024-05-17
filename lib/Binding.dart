import 'package:get/get.dart';
import 'package:todo/Controllers/DetailController.dart';
import 'package:todo/Controllers/TodoController.dart';
import 'package:todo/Controllers/UserController.dart';

class Binding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => UserController(), fenix: true);
  }
}

class TodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController(), fenix: true);
  }
}

class DetailBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailController(), fenix: true);
  }
}
