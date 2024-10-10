import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/view/attributes/attribute.dart';
import 'package:isotopeit_b2b/view/auction/auction.dart';
import 'package:isotopeit_b2b/view/category/category.dart';
import 'package:isotopeit_b2b/view/login/login.dart';
import 'package:isotopeit_b2b/view/order/order.dart';
import 'package:isotopeit_b2b/view/product/product.dart';
import 'package:isotopeit_b2b/view/report/report.dart';
import 'package:isotopeit_b2b/view/shopbanner/shop_banner.dart';
import 'package:isotopeit_b2b/view/shopsettings/shop_settings.dart';
import 'package:isotopeit_b2b/view/inventory.dart/inventory.dart';
import 'package:isotopeit_b2b/view/wallet/wallet.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {},
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
              Card(
                child: ListTile(
                  title: const Text("Attribute Management"),
                  leading: const Icon(Icons.family_restroom),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(SizeColorManager());
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text("Inventory Management"),
                  leading: const Icon(Icons.inventory),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(ProductManager(), transition: Transition.leftToRightWithFade);
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text("Product Management"),
                  leading: const Icon(Icons.shop),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(ProductListScreen(), transition: Transition.rightToLeftWithFade);
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text("Category and Tag Management"),
                  leading: const Icon(Icons.category),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(CategoryListPage());
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text("Order Management"),
                  leading: const Icon(Icons.accessible),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(OrderListScreen(), transition: Transition.rightToLeftWithFade);
                  },
                ),
              ),
               const SizedBox(height: 5.0),
               Card(
                child: ListTile(
                  title: const Text("Sub-order and Courier Management"),
                  leading: const Icon(Icons.send),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text("Shop Banner Management"),
                  leading: const Icon(Icons.image),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(  BannerManager());
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text("Wallet Management"),
                  leading: const Icon(Icons.currency_exchange),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(WalletManager(), transition: Transition.rightToLeftWithFade);
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text("Auction Management"),
                  leading: const Icon(Icons.report),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(AuctionManager(), transition: Transition.rightToLeftWithFade);
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text("Shop Settings"),
                  leading: const Icon(Icons.shop_rounded),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(ShopSettingsPage(), transition: Transition.rightToLeftWithFade);
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text(" Reports"),
                  leading: const Icon(Icons.note),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(ReportManagerPage(), transition: Transition.rightToLeftWithFade);
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                child: ListTile(
                  title: const Text("App Settings"),
                  leading: const Icon(Icons.settings),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {},
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
