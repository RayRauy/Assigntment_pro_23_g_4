import 'package:get/get.dart';
import 'package:pro_23/controller/user_controller.dart';
import '../controller/post_controller.dart';


class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}
