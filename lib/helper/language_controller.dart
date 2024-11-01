import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var locale = const Locale('en', 'US').obs; // Default language is English

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  void changeLanguage(String langCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (langCode) {
      case 'bn':
        locale.value = const Locale('bn', 'BD'); // Bangla
        break;
      case 'ar':
        locale.value = const Locale('ar', 'SA'); // Arabic
        Get.updateLocale(locale.value);
        Get.forceAppUpdate(); // To refresh layout direction for RTL
        break;
      default:
        locale.value = const Locale('en', 'US'); // English
    }

    // Save language choice to preferences
    await prefs.setString('languageCode', langCode);
    Get.updateLocale(locale.value);
  }

  Future<void> _loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('languageCode') ?? 'en';

    // Set saved language and RTL mode if Arabic is selected
    changeLanguage(langCode);
  }
}
