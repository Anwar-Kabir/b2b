import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/helper/theme_controller.dart';
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/view/login/login.dart';
import 'package:isotopeit_b2b/view/login/login_controller.dart';
import 'package:isotopeit_b2b/view/personal_info/personal_info.dart';

final ThemeController themeController = Get.find();

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut<LoginController>(() => LoginController());
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              Card(
                child: ListTile(
                  title: const Text("Personal Info"),
                  leading: const Icon(Icons.info),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(const PersonalInfo(), transition: Transition.rightToLeftWithFade);
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text("Notification"),
                  leading: const Icon(Icons.fact_check),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 5.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Text(
                'Switch Day and Night Mode',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Switch(
                  value: themeController.isDarkMode.value,
                  onChanged: (value) {
                    themeController.toggleTheme();
                  },
                ),
              ),
                ],
              ),

             
           

              Card(
                child: ListTile(
                  title: const Text("Log out"),
                  leading: const Icon(Icons.logout),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    _showLogoutDialog();
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text("Delete Account"),
                  leading: const Icon(Icons.delete),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () async {
                    // Show the alert dialog
                    _showDeleteDialog();
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    )));
  }
}

void _showDeleteDialog() {
  RxBool isDeleting = false.obs;

  Get.dialog(
    Obx(
      () => AlertDialog(
        title: const Text("Delete Account"),
        content: isDeleting.value
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  //Text("Processing..."),
                ],
              )
            : const Text("Are you sure you want to delete your account?"),
        actions: isDeleting.value
            ? [] // Disable buttons while processing
            : [
                TextButton(
                  onPressed: () {
                    Get.back(); // Close the dialog
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    // Start showing the progress indicator
                    isDeleting.value = true;

                    // Wait for 2 seconds to simulate processing
                    await Future.delayed(const Duration(seconds: 2));

                    // After deleting the token, navigate to the login page with a smooth transition
                    
                    TokenService().clearToken();

                    Get.offAll(() => const Login(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500));

                    // Optionally show success message
                    Get.snackbar(
                      'Success',
                      'Account deleted successfully',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );

                    // Close the dialog after success
                    Get.back();
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
      ),
    ),
  );
}

void _showLogoutDialog() {
  RxBool isDeleting = false.obs;

  Get.dialog(
    Obx(
      () => AlertDialog(
        title: const Text("Logout"),
        content: isDeleting.value
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  //Text("Processing..."),
                ],
              )
            : const Text("Are you sure you want to Logout?"),
        actions: isDeleting.value
            ? [] // Disable buttons while processing
            : [
                TextButton(
                  onPressed: () {
                    Get.back(); // Close the dialog
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    // Start showing the progress indicator
                    isDeleting.value = true;

                    // Wait for 2 seconds to simulate processing
                    await Future.delayed(const Duration(seconds: 2));

                    // Simulate the deletion process by removing the token

                    // After deleting the token, navigate to the login page with a smooth transition
                    Get.offAll(() => const Login(),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 500));

                    // Optionally show success message
                    Get.snackbar(
                      'Success',
                      'Account Logout successfully',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );

                    // Close the dialog after success
                    Get.back();
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
      ),
    ),
  );
}
