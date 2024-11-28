import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/home/home_controller.dart';
import 'package:isotopeit_b2b/view/wallet/withdraw_request/request_money_controller.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';

class BalanceRequest extends StatefulWidget {
  const BalanceRequest({super.key});

  @override
  State<BalanceRequest> createState() => _BalanceRequestState();
}

class _BalanceRequestState extends State<BalanceRequest> {
  final WalletController balanceController = Get.put(WalletController());
  final WalletWithdrawController withdrawController =
      Get.put(WalletWithdrawController());

  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    balanceController.fetchWalletBalance();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Withdraw Request',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Section
            Center(
              child: SizedBox(
                child: Obx(() {
                  if (balanceController.isLoading.value) {
                    return CircularProgressIndicator(); // Show loading indicator
                  } else if (!balanceController.isWalletAvailable.value) {
                    return Text(
                        "No wallet available."); // Show no wallet message
                  } else {
                    return _buildBalanceCard(balanceController
                        .wallet.value.balance); // Show balance card
                  }
                }),
              ),
            ),
            const SizedBox(height: 20),

            const LabelWithAsterisk(
              labelText: "Request Money",
              isRequired: true,
            ),

            // Amount Input Field
            CustomTextField(
              prefixIcon: Icons.monetization_on,
              hintText: 'Enter amount',
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Request Button
            const Spacer(),
            Obx(() => withdrawController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        int? amount = int.tryParse(amountController.text);
                        if (amount != null && amount > 0) {
                          withdrawController.requestWithdraw(amount);
                        } else {
                          Get.snackbar("Error", "Please enter a valid amount",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        }
                      },
                      icon: const Icon(Icons.send),
                      label: const Text("Request"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(
                            double.infinity, 50), // Make button full-width
                        backgroundColor: AppColor.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  // Available Balance Card
  Widget _buildBalanceCard(String balance) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Available Balance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            Text(
              '৳ $balance',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
