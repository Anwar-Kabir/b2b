import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  // Observable for connectivity status
  var isConnected = false.obs;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isConnected.value = result != ConnectivityResult.none;
    // Show an alert if the connection status changes
    if (!isConnected.value) {
      Get.snackbar(
        "No Internet Connection",
        "Please check your internet settings.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor ?? Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        
        
      );
    }
  }
}
