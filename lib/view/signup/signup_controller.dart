import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/validator.dart';
import 'package:isotopeit_b2b/view/login/login.dart';

class SignUpController extends GetxController {
  // Variables
  var obscurePassword = true.obs;
  var isAgreed = false.obs;
  var isButtonEnabled = false.obs;

  // Form validation key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //app validation from
  final appValidator = AppValidation();
  final appNameValidator = TextEditingController();
  final appPhoneValidator = TextEditingController();
  final appEmailValidator = TextEditingController();
  final appPasswordValidator = TextEditingController();
  final appConformPasswordValidator = TextEditingController();

  @override
  void dispose() {
    appNameValidator.dispose();
    appPhoneValidator.dispose();
    appEmailValidator.dispose();
    appPasswordValidator.dispose();
    appConformPasswordValidator.dispose();
    super.dispose();
  }

  // Confirm password validation function
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != appPasswordValidator.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Update agreement status
  void updateAgreement(bool? value) {
    isAgreed.value = value ?? false;
    updateButtonState();
  }

  // Update button state based on form and agreement
  void updateButtonState() {
    isButtonEnabled.value =
        isAgreed.value && formKey.currentState?.validate() == true;
  }

  //===>
  void onFieldChanged() {
    formKey.currentState?.validate();

    updateButtonState();
  }

  // Handle the sign-up logic
  Future<void> handleSignup() async {
    if (formKey.currentState!.validate() && isAgreed.value) {
      Get.snackbar("Success", "Sign up successful!",
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.offAll(const Login());
    } else {
      Get.snackbar("Error", "Please complete the form",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
