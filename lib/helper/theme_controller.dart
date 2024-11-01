import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs; // Default is light mode

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPreferences(); // Load saved theme mode on initialization
  }

  // Load theme from SharedPreferences
  Future<void> _loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value =
        prefs.getBool('isDarkMode') ?? false; // Default to light mode
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Toggle theme and save to SharedPreferences
  void toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode.value);
  }
}
