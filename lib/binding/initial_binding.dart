import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controller/auth_controller.dart';
import '../core/util/api_client.dart';
import '../repository/auth_repository.dart';
import '../repository/user_repository.dart';
import '../service/network_service.dart';
import '../service/storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final storage = Get.put<StorageService>(StorageService(), permanent: true);
    final apiClient = Get.put(ApiClient(storage), permanent: true);

    Get.put<AuthRepository>(AuthRepository(), permanent: true);
    final userRepo = Get.put<UserRepository>(UserRepository(apiClient), permanent: true);

    Get.put<AuthController>(AuthController(userRepo), permanent: true);
    Get.put<NetworkService>(NetworkService(), permanent: true);
  }
}
