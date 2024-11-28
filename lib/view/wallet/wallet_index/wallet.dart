 




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/home/home_controller.dart';
import 'package:isotopeit_b2b/view/wallet/wallet_index/wallet_index_controller.dart';
import 'package:isotopeit_b2b/view/wallet/withdraw_request/wallet_request_money.dart';

class Wallet extends StatelessWidget {
  final WalletIndexController controller = Get.put(WalletIndexController());
  final WalletController balanceController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Withdraw',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Get.to(const BalanceRequest(),
                  transition: Transition.rightToLeftWithFade);
            },
            label: const Text(
              "Request Withdraw",
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.requests.isEmpty) {
          return Center(child: Text("No withdraw requests found"));
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.requests.length,
                    itemBuilder: (context, index) {
                      final request = controller.requests[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(
                            "Requested By: ${request.requestedBy}",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Requested At: ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(request.requestedAt))}",
                              ),
                              Text("Amount: \$${request.amount}"),
                            ],
                          ),
                          trailing: StatusBadge(status: request.status),
                          onTap: () {
                            // Navigate to the details page with the request details
                            // Get.to(() => WalletRequestDetails(request: request));
                          },
                        ),
                      );
                    },
                  ),
                   SizedBox(height: 20,)
                ],
               
              ),
            ),
          );
        }
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: controller.fetchWithdrawRequests,
      //   child: Icon(Icons.refresh),
      // ),
    );
  }

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

class StatusBadge extends StatelessWidget {
  final int status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Determine background color and text based on status
    Color bgColor;
    String statusText;
    if (status == 1) {
      bgColor = Colors.green;
      statusText = 'Approved';
    } else if (status == 2) {
      bgColor = Colors.red;
      statusText = 'Rejected';
    } else {
      bgColor = Colors.orange;
      statusText = 'Pending';
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        statusText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
