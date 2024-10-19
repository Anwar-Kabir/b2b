import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/login/login_controller.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    // Load user info if not already loaded
    if (loginController.userInfo.isEmpty) {
      loginController.loadUserInfo();
      print("==================>>>");
      print(loginController.userInfo['email']);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Info',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        // Check if user info is available
        if (loginController.userInfo.isEmpty) {
          
          return const Center(child: Text('No user data available'));
        }

        // Display user information
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: loginController.userInfo['profile_image'] !=
                          null
                      ? NetworkImage(loginController.userInfo['profile_image'])
                      : const AssetImage('assets/images/default_profile.png')
                          as ImageProvider,
                ),
              ),
              const SizedBox(height: 20),

              // Using Table for better alignment
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                children: [
                  _buildTableRow('Name', loginController.userInfo['name']),
                  _buildTableRow('Email', loginController.userInfo['email']),
                  _buildTableRow(
                      'Date of Birth', loginController.userInfo['dob']),
                  _buildTableRow('Gender', loginController.userInfo['sex']),
                  _buildTableRow(
                      'Description', loginController.userInfo['description']),
                  _buildTableRow('Active',
                      loginController.userInfo['active'] == 1 ? 'Yes' : 'No'),
                  _buildTableRow('Email Verified',
                      loginController.userInfo['email_verified_at']),
                  _buildTableRow(
                      'Shop ID', loginController.userInfo['shop_id']),
                  _buildTableRow(
                      'Role ID', loginController.userInfo['role_id']),
                  _buildTableRow(
                      'Created At', loginController.userInfo['created_at']),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  // Helper function to build table rows
  TableRow _buildTableRow(String key, dynamic value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            key,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            value?.toString() ?? 'N/A',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
