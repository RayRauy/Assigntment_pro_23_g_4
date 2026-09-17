import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_23/repository/user_repository.dart';

import '../model/user/user_data_model.dart';


class UserController extends GetxController{
  UserController(this._userRepo);
  final UserRepository _userRepo;

  final users = <userData>[].obs;

  userData? editingUser;

  // Form Controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isPasswordVisible = false.obs;

  // =========================
  // State
  // =========================
  final RxString existingImageUrl = ''.obs;
  final RxnString usernameError = RxnString();
  final RxnString passwordError = RxnString();
  final isPickingImage = false.obs;
  final selectedImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();
  final isCreating = false.obs;
  final isDeleting = false.obs;
  final isUpdating = false.obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final errorMessage = ''.obs;
  final searchTerm = ''.obs;
  final enabled = true.obs;


// =========================
  // Pagination
  // =========================

  final int size = 10;
  Timer? _searchTimer;
  int _page = 0;
  int _totalPages = 1;
  int _total = 0;

  int get total => _total;
  bool get hasMore => _page + 1 < _totalPages;

  // =========================
  // Scroll
  // =========================

  final ScrollController scrollController = ScrollController();

  //===password visible==//

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onInit() {
    super.onInit();

    loadFirstPage();
    scrollController.addListener(_onScroll);

    usernameController.addListener(() {
      if (usernameError.value != null && usernameController.text.trim().isNotEmpty) {
        usernameError.value = null;
      }
    });

    passwordController.addListener(() {
      if (passwordError.value != null && passwordController.text.trim().isNotEmpty) {
        passwordError.value = null;
      }
    });
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  // =========================
  // Load First Page
  // =========================

  Future<void> loadFirstPage({String? username, bool debounce = false,}) async {
    searchTerm.value = username ?? searchTerm.value;

    _searchTimer?.cancel();

    if (debounce) {
      _searchTimer = Timer(
        Duration(milliseconds: 400),
            () {
          loadFirstPage(
            username: searchTerm.value,
            debounce: false,
          );
        },
      );

      return;
    }

    if (isLoading.value) return;
    errorMessage.value = '';

    _page = 0;
    _totalPages = 1;
    _total = 0;
    // Save search text for pagination
    searchTerm.value = username ?? '';

    try {
      final (UserDataModel? page, String? error) =
      await _userRepo.getUserPage(
        page: 0,
        size: size,
        username: searchTerm.value,
      );

      if (error != null) {
        errorMessage.value = error;
        users.clear();
        return;
      }

      if (page == null) {
        errorMessage.value = 'No data';
        users.clear();
        return;
      }

      users.assignAll(page.data ?? []);

      _applyMeta(page);
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // Load More
  // =========================

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore) return;

    isLoadingMore.value = true;

    try {
      final nextPage = _page + 1;

      final (UserDataModel? page, String? error) =
      await _userRepo.getUserPage(
        page: nextPage,
        size: size,
        username: searchTerm.value,
      );

      if (error != null) {
        errorMessage.value = error;
        return;
      }

      if (page == null) {
        errorMessage.value = 'No data';
        return;
      }

      users.addAll(page.data ?? []);

      _applyMeta(page);
    } finally {
      isLoadingMore.value = false;
    }
  }

  // =========================
  // Pagination
  // =========================

  void _applyMeta(UserDataModel page) {
    final Pagination? pagination = page.pagination;

    if (pagination == null) {
      _total = 0;
      _totalPages = 1;
      return;
    }

    _page = pagination.page ?? 0;
    _totalPages = pagination.totalPages ?? 1;
    _total = pagination.total ?? 0;

    print(
      'Pagination: '
          'page=$_page, '
          'totalPages=$_totalPages, '
          'total=$_total',
    );
  }

  Future<void> createUser() async {
    if (isCreating.value) return;

    final username = usernameController.text.trim();
    final nickName = nickNameController.text.trim();
    final password = passwordController.text.trim();

    usernameError.value = null;
    passwordError.value = null;

    bool hasError = false;
    if (username.isEmpty) {
      usernameError.value = 'Username is required';
      hasError = true;
    }

    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      hasError = true;
    }

    if (hasError) return;

    try {
      isCreating.value = true;

      // =========================
      // 1. Create user
      // =========================

      final (userData? user, String? error) =
      await _userRepo.createUser(
        username: username,
        nickName: nickName,
        password: password,
      );

      if (error != null) {
        Get.snackbar(
          'Error',
          error,
        );
        return;
      }

      if (user == null) {
        Get.snackbar(
          'Error',
          'Failed to create user',
        );
        return;
      }

      // 2. Upload Image if exists
      if (selectedImage.value != null && user.id != null) {
        final (bool success, String? uploadError) = await _userRepo.uploadUserImage(
          userId: user.id!,
          filePath: selectedImage.value!.path,
        );

        if (!success) {
          Get.snackbar(
            'Partial Success',
            'User created, but image upload failed: ${uploadError ?? "Unknown error"}',
            duration: const Duration(seconds: 5),
          );
        }
      }

      // =========================
      // 2.5 Update Enabled Status via specific endpoint
      // =========================
      if (user.id != null) {
        final (bool toggleSuccess, String? toggleError) = await _userRepo.userEnabled(
          userId: user.id!,
          enabled: enabled.value,
        );

        if (toggleSuccess) {
          user.enabled = enabled.value;
        } else {
          Get.snackbar(
            'Partial Success',
            'User created, but failed to set enabled status: ${toggleError ?? "Unknown error"}',
            duration: const Duration(seconds: 5),
          );
        }
      }


      // =========================
      // 3. Add to local list
      // =========================

      users.insert(0, user);

      // =========================
      // 4. Clear form
      // =========================

      usernameController.clear();
      nickNameController.clear();
      passwordController.clear();
      enabled.value = true;

      selectedImage.value = null;
      editingUser = null;

      Get.back();

      Get.snackbar(
        'Success',
        'User created successfully',
      );
    } finally {
      isCreating.value = false;
    }
  }

  Future<void> pickImage() async {
    if (isPickingImage.value) return;

    try {
      isPickingImage.value = true;
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (e is PlatformException && e.code == 'already_active') {
        // Ignore this error as it just means the picker is already open
        return;
      }
      Get.snackbar('Error', 'Failed to pick image: $e');
    } finally {
      isPickingImage.value = false;
    }
  }

  Future<void> updateUser() async {
    if (isUpdating.value) return;

    if (editingUser == null) {
      Get.snackbar(
        'Error',
        'User not found',
      );
      return;
    }

    final int? id = editingUser!.id;

    if (id == null) {
      Get.snackbar(
        'Error',
        'User ID not found',
      );
      return;
    }

    final username = usernameController.text.trim();
    final nickName = nickNameController.text.trim();
    bool hasError = false;

    if (username.isEmpty) {
      usernameError.value = 'Username is required';
      hasError = true;
    }

    if (hasError) return;

    try {
      isUpdating.value = true;

      // =========================
      // Update User
      // =========================
      final (userData? updatedUser, String? error) =
      await _userRepo.updateUser(
        userId: id,
        username: username,
        nickName: nickName,
      );

      // 2. Upload Image if exists
      if (selectedImage.value != null && updatedUser?.id != null) {
        final (bool success, String? uploadError) = await _userRepo.uploadUserImage(
          userId: updatedUser!.id!,
          filePath: selectedImage.value!.path,
        );

        if (!success) {
          Get.snackbar(
            'Partial Success',
            'User created, but image upload failed: ${uploadError ?? "Unknown error"}',
            duration: const Duration(seconds: 5),
          );
        }
      }

      // =========================
      // 2.5 Update Enabled Status via specific endpoint
      // =========================
      if (updatedUser?.id != null) {
        final (bool toggleSuccess, String? toggleError) = await _userRepo.userEnabled(
          userId: updatedUser!.id!,
          enabled: enabled.value,
        );

        if (toggleSuccess) {
          updatedUser.enabled = enabled.value;
        } else {
          Get.snackbar(
            'Partial Success',
            'User created, but failed to set enabled status: ${toggleError ?? "Unknown error"}',
            duration: const Duration(seconds: 5),
          );
        }
      }

      // =========================
      // API Error
      // =========================
      if (error != null) {
        Get.snackbar(
          'Error',
          error,
        );
        return;
      }

      // =========================
      // No updated user returned
      // =========================
      if (updatedUser == null) {
        Get.snackbar(
          'Error',
          'Failed to update user',
        );
        return;
      }

      // =========================
      // Update local list
      // =========================
      final index = users.indexWhere(
            (user) => user.id == id,
      );

      if (index != -1) {
        users[index] = updatedUser;
        users.refresh();
      }

      // =========================
      // Clear editing state
      // =========================
      editingUser = null;

      usernameController.clear();
      nickNameController.clear();
      passwordController.clear();

      // Keep your enabled state
      enabled.value = true;

      // =========================
      // Close form
      // =========================
      Get.back();

      Get.snackbar(
        'Success',
        'User updated successfully',
      );
    } finally {
      isUpdating.value = false;
    }
  }



  Future<void> deletePost(userData user) async {
    if (isDeleting.value) return;

    final int? id = user.id;

    if (id == null) {
      Get.snackbar(
        'Error',
        'Post ID not found',
      );
      return;
    }

    try {
      isDeleting.value = true;

      final (bool success, String? error) =
      await _userRepo.deleteUser(
        id: id,
      );

      if (error != null) {
        Get.snackbar(
          'Error',
          error,
        );
        return;
      }

      if (!success) {
        Get.snackbar(
          'Error',
          'Failed to delete post',
        );
        return;
      }

      // Remove post from local list
      users.removeWhere(
            (item) => item.id == id,
      );

      Get.snackbar(
        'Success',
        'Post deleted successfully',
      );
    } finally {
      isDeleting.value = false;
    }
  }

  void confirmDeletePost(userData user) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Post'),
        content: Text(
          'Are you sure you want to delete "${user.username ?? ''}"?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),

          ElevatedButton(
            onPressed: () {
              Get.back();
              deletePost(user);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void editUser(userData user) {
    editingUser = user;

    usernameController.text = user.username ?? '';
    nickNameController.text = user.nickName ?? '';
    enabled.value = user.enabled ?? false;
    existingImageUrl.value = user.imageUrl ?? '';
    Get.toNamed('/users-edit');
  }

  void startCreate() {
    editingUser = null;

    usernameController.clear();
    nickNameController.clear();
    passwordController.clear();
    enabled.value = true;
    usernameError.value = null;
    passwordError.value = null;
    selectedImage.value = null;
    existingImageUrl.value = '';
    Get.toNamed('/users/form');
  }
  // =========================
  // Dispose
  // =========================

  @override
  void onClose() {
    _searchTimer?.cancel();
    scrollController.dispose();
    super.onClose();
  }
}