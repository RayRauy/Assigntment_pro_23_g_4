import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkService extends GetxService {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkInitialStatus();
  }

  Future<void> _checkInitialStatus() async {
    final List<ConnectivityResult> results = await _connectivity.checkConnectivity();
    _handleStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    _handleStatus(results);
  }

  void _handleStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none) || results.isEmpty) {
      _showOfflineSnackbar();
    } else {
      _hideOfflineSnackbar();
    }
  }

  bool _isSnackbarVisible = false;

  void _showOfflineSnackbar() {
    if (_isSnackbarVisible) return;

    _isSnackbarVisible = true;
    Get.rawSnackbar(
      messageText: const Text(
        'No Internet Connection',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      icon: const Icon(Icons.wifi_off, color: Colors.white),
      backgroundColor: Colors.red.shade700,
      isDismissible: false,
      duration: const Duration(days: 1), // Permanent
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      borderRadius: 10,
    );
  }

  void _hideOfflineSnackbar() {
    if (!_isSnackbarVisible) return;

    _isSnackbarVisible = false;
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.rawSnackbar(
      messageText: const Text(
        'Internet Restored',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      icon: const Icon(Icons.wifi, color: Colors.white),
      backgroundColor: Colors.green.shade700,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      borderRadius: 10,
    );
  }
}
