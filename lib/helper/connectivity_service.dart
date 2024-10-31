 // connectivity_service.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/view/splash/splash.dart';
import 'package:isotopeit_b2b/widget/no_internet_page.dart';
 

class ConnectivityService extends GetxService {
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
    if (!isConnected.value) {
      // Navigate to the NoInternetPage if disconnected
      Get.to(() => const NoInternetPage());
    } else {
      // Go back to the previous page if reconnected
      if (Get.currentRoute == '/NoInternetPage') {
        // Get.back();
       Get.offAll(() => const Splash());
      }
    }
  }

  void checkConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }
}



   