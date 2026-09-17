import 'package:get/get.dart';

import '../controller/post_controller.dart';
import '../controller/user_controller.dart';
import '../core/util/api_client.dart';
import '../repository/post_repository.dart';
import '../repository/user_repository.dart';
import '../service/storage_service.dart';

/// Dependencies for the tabbed shell.
///
/// The tabs are built inside `MainScreen`, not reached through their own
/// routes, so whatever they need has to be registered here.
class MainBinding extends Bindings {
  @override
  void dependencies() {
    // PostBinding().dependencies();
    // UserBinding().dependencies();
    // 1. Core Services shared by both layers
    final storage = Get.find<StorageService>();
    final apiClient = Get.put(ApiClient(storage));

    // 2. Instantiate and inject Post layer immediately
    final postRepo = Get.put(PostRepository(apiClient));
    Get.put(PostController(postRepo));

    // 3. Instantiate and inject User layer immediately
    final userRepo = Get.put(UserRepository(apiClient));
    Get.put(UserController(userRepo));
  }
}
