import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/view/home.dart';

class LoginController extends GetxController {
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> login() async {
    if (validateForm()) {
      //Get.offAll(const AppBottomNavigationBar());
      debugPrint("login");
      Get.offAll(const BottomNav());
    } else {
      // Get.snackbar("Error", "Invalid email or password",
      //     backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
