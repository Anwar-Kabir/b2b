import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/utils/validator.dart';
import 'package:isotopeit_b2b/view/BottomNav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var obscurePassword = true.obs; // Make it reactive
  var isLoading = false.obs; // Make loading state reactive
  final formKey = GlobalKey<FormState>();

  //app validation from
  final appValidator = AppValidation();
  final appEmailValidator = TextEditingController();
  final appPasswordValidator = TextEditingController();

  // Store user info
  var userInfo = {}.obs;

  @override
  void dispose() {
    super.dispose();
    appEmailValidator.dispose();
    appPasswordValidator.dispose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Validate the form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Login API call with headers
  Future<void> login() async {
    if (!validateForm()) return;

    isLoading.value = true;

    final url = Uri.parse(AppURL.login);
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      'email': appEmailValidator.text,
      'password': appPasswordValidator.text,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = data['user']; // Extract user info

        // Save token and user info in shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('userInfo', json.encode(user));

        await TokenService().setToken(token);

        // Store the user info in memory
        userInfo.value = user;

        // Navigate to home page after successful login
        Get.offAll(() => const BottomNav(),
            transition: Transition.rightToLeftWithFade);

        // Show success notification
        Get.snackbar(
          "Success",
          'Login successful.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );
      } else {
        // Show error if login fails
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          errorData['message'] ?? 'Login failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch stored user info (optional if you want to load user info later)
  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUserInfo = prefs.getString('userInfo');
    if (storedUserInfo != null) {
      userInfo.value = json.decode(storedUserInfo);
    }
  }
}
