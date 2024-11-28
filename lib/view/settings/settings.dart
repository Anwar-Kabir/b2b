import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/helper/language_controller.dart';
import 'package:isotopeit_b2b/helper/theme_controller.dart';
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/utils/translations/language_data.dart';
import 'package:isotopeit_b2b/view/login/login.dart';
import 'package:isotopeit_b2b/view/personal_info/personal_info.dart';
import 'package:isotopeit_b2b/view/splash/splash.dart';

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
                    Get.to(const PersonalInfo(),
                        transition: Transition.rightToLeftWithFade);
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              // Card(
              //   child: ListTile(
              //     title: const Text("Notification"),
              //     leading: const Icon(Icons.fact_check),
              //     trailing: const Icon(Icons.arrow_forward),
              //     onTap: () {},
              //   ),
              // ),
              const SizedBox(height: 5.0),

              // Language Change Button
              Card(
                child: ListTile(
                  title: const Text("Change Language"),
                  leading: const Icon(Icons.language),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    _showLanguageDialog(context);
                  },
                ),
              ),

              const SizedBox(height: 5.0),

             

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
              // Card(
              //   child: ListTile(
              //     title: const Text("Delete Account"),
              //     leading: const Icon(Icons.delete),
              //     trailing: const Icon(Icons.arrow_forward),
              //     onTap: () async {
              //       // Show the alert dialog
              //       _showDeleteDialog();
              //     },
              //   ),
              // ),
              
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text(
              //       'Switch Day and Night Mode',
              //       style: TextStyle(fontSize: 18),
              //     ),
              //     const SizedBox(height: 20),
              //     Obx(
              //       () => Switch(
              //         value: themeController.isDarkMode.value,
              //         onChanged: (value) {
              //           themeController.toggleTheme();
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    )));
  }

  void _showLanguageDialog(BuildContext context) {
    final languageController = Get.find<LanguageController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Language"),
          content: SizedBox(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SvgPicture.asset(
                    languages[index].flag,
                    width: 30,
                    height: 30,
                  ),
                  title: Text(languages[index].name),
                  onTap: () {
                    Get.back(); // Close the dialog
                    Get.dialog(
                      const Center(
                        child: const CircularProgressIndicator(),
                      ),
                      barrierDismissible: false,
                    );

                    // Change language and navigate to the splash screen after a delay
                    Future.delayed(const Duration(seconds: 2), () {
                      languageController.changeLanguage(languages[index].code);
                      Get.back(); // Close the loading indicator
                      Get.offAll(() => const Splash());
                    });
                  },
                );
              },
            ),
          ),
        );
      },
    );
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
