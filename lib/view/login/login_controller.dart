import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  bool obscurePassword = true;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Store user info
  var userInfo = {}.obs;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update(); // Refresh the UI
  }

  // Validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Validate the form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Login API call with headers
  Future<void> login() async {
    if (!validateForm()) return;

    isLoading = true;
    update(); // Show circular avatar

    final url = Uri.parse(AppURL.login);
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      'email': emailController.text,
      'password': passwordController.text,
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
      isLoading = false;
      update(); // Hide loading spinner
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
