import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pro_23/service/storage_service.dart';

import '../model/user/user_data_model.dart';
import '../repository/auth_repository.dart';
import '../repository/user_repository.dart';

class AuthController extends GetxController {
  AuthController(this._userRepo);

  final AuthRepository _authRepo = Get.find<AuthRepository>();
  final UserRepository _userRepo;
  final StorageService _storageService = Get.find<StorageService>();

  final Rxn<userData> currentUserProfile = Rxn<userData>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final token = await _storageService.getString('token');
    if (token == null || token.isEmpty) return;

    final (userData? user, String? error) = await _userRepo.getCurrentUser();
    if (user != null) {
      currentUserProfile.value = user;
    }
  }

  Future<void> login() async {
    if (usernameController.text.trim().isEmpty) {
      errorMessage.value = 'Username is required';
      return;
    }

    if (passwordController.text.isEmpty) {
      errorMessage.value = 'Password is required';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final (String? token, String? error) = await _authRepo.login(
      username: usernameController.text.trim(),
      password: passwordController.text,
    );

    isLoading.value = false;

    if (error != null) {
      errorMessage.value = error;
      return;
    }

    if (token == null) {
      errorMessage.value = 'Token not found';
      return;
    }
    await _storageService.saveString('token', token);
    print('LOGIN TOKEN: $token');

    await fetchProfile();

    Get.offAllNamed('/');
  }

  Future<void> logout() async {
    await _storageService.remove('token');

    usernameController.clear();
    passwordController.clear();
    errorMessage.value = '';

    Get.offAllNamed('/login');
  }

  Future<void> checkLoginStatus() async {
    final token = await _storageService.getString('token');

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed('/');
    }
  }
}
