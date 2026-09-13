import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pro_23/repository/user_repository.dart';

import '../model/user/user_data_model.dart';


class UserController extends GetxController{
  final UserRepository _userRepo = Get.put(UserRepository());
  final users = <userData>[].obs;
  userData? editingUser;
  // =========================
  // State
  // =========================

  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final errorMessage = ''.obs;
  final searchTerm = ''.obs;

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

  @override
  void onInit() {
    super.onInit();

    loadFirstPage();
    scrollController.addListener(_onScroll);
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

  Future<void> loadFirstPage({
    String? username,
    String? nickName,
    bool? enabled,
    bool debounce = false,
  }) async {
    searchTerm.value = username ?? searchTerm.value;

    _searchTimer?.cancel();

    if (debounce) {
      _searchTimer = Timer(
        const Duration(milliseconds: 400),
            () {
          loadFirstPage(
            username: username,
            nickName: nickName,
            enabled: enabled,
            debounce: false,
          );
        },
      );

      return;
    }

    if (isLoading.value) return;

    isLoading.value = true;
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
        username: username,
        nickName: nickName,
        published: enabled,
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