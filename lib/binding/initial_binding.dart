import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../repository/auth_repository.dart';
import '../service/storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.put<AuthRepository>(AuthRepository(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
