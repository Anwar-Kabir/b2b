import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:isotopeit_b2b/helper/language_controller.dart';
import 'package:isotopeit_b2b/view/home/home_controller.dart';
import 'package:isotopeit_b2b/view/home/summary/summary_controller.dart';

class HomePage extends StatelessWidget {
      HomePage({Key? key}) : super(key: key);

  final WalletController walletController = Get.put(WalletController());

   final LanguageController languageController = Get.find();

    final SummaryController controller = Get.put(SummaryController());

  @override
  Widget build(BuildContext context) {
    print("balance");
    print(walletController.wallet.value.balance);
      
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Available Balance
                 Center(
                child: SizedBox(
                  child: Obx(() {
                    if (walletController.isLoading.value) {
                      return CircularProgressIndicator(); // Show loading indicator
                    } else if (!walletController.isWalletAvailable.value) {
                      return Text(
                          "No wallet available."); // Show no wallet message
                    } else {
                      return _buildBalanceCard(walletController
                          .wallet.value.balance); // Show balance card
                    }
                  }),
                ),
              ),

              const SizedBox(height: 20),

              // _buildSummaryGrid(context),
               Obx(() => _buildSummaryGrid(context)),

              const SizedBox(height: 20),

              // Auction Section (Upcoming and Live Auctions)
              //_buildAuctionSection(context),

              const SizedBox(height: 20),

              // Inventory Section
              //_buildInventorySection(context),

              const SizedBox(height: 20),
              //order section
              //_buildOrderSection(context),
            ],
          ),
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

  // Auction Section (Upcoming and Live Auctions)
  Widget _buildAuctionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Auction',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            // Upcoming Auction
            Expanded(
              child: Card(
                elevation: 4.0,
                child: InkWell(
                  onTap: () {
                    // Navigate to Upcoming Auction screen
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(Icons.event, size: 40, color: Colors.blue),
                        SizedBox(height: 10),
                        Text(
                          'Upcoming Auction',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Live Auction
            Expanded(
              child: Card(
                elevation: 4.0,
                child: InkWell(
                  onTap: () {
                    // Navigate to Live Auction screen
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(Icons.live_tv, size: 40, color: Colors.red),
                        SizedBox(height: 10),
                        Text(
                          'Live Auction',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Summary Grid Section (Orders, Couriers, Products)
   Widget _buildSummaryGrid(BuildContext context) {
    return Column(
      children: [
        _buildSummaryRow('Total Orders', '${controller.totalOrders.value}',
            Icons.shopping_cart, Colors.orange),
        const SizedBox(height: 10),
        _buildSummaryRow('Total Couriers', '${controller.totalCouriers.value}',
            Icons.local_shipping, Colors.purple),
        const SizedBox(height: 10),
        _buildSummaryRow('Total Products', '${controller.totalProducts.value}',
            Icons.inventory, Colors.green),
        const SizedBox(height: 10),
        _buildSummaryRow('Total Inventory',
            '${controller.totalInventory.value}', Icons.store, Colors.blue),
      ],
    );
  }

  Widget _buildSummaryRow(
      String title, String count, IconData icon, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 40), // Icon on the left
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
        Text(
          count,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  // Summary Card
  Widget _buildSummaryCard(
      String title, String count, IconData icon, Color color) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          // Navigate to respective screen
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                count,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Inventory Section with "View All" button
  Widget _buildInventorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Inventory',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Inventory List page
              },
              child: const Text(
                'View All',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Inventory Product Grid
        Row(
          children: [
            // Upcoming Auction
            Expanded(
              child: Card(
                elevation: 4.0,
                child: InkWell(
                  onTap: () {
                    // Navigate to Upcoming Auction screen
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(Icons.shop, size: 40, color: Colors.blue),
                        SizedBox(height: 10),
                        Text(
                          'Product 1',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'In Stock 3',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Live Auction
            Expanded(
              child: Card(
                elevation: 4.0,
                child: InkWell(
                  onTap: () {
                    // Navigate to Live Auction screen
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(Icons.production_quantity_limits,
                            size: 40, color: Colors.red),
                        SizedBox(height: 10),
                        Text(
                          'Product 2',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'In Stock 10',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //order
  Widget _buildOrderSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Order',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Inventory List page
              },
              child: const Text(
                'View All',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Inventory Product Grid
        Row(
          children: [
            // Upcoming Auction
            Expanded(
              child: Card(
                elevation: 4.0,
                child: InkWell(
                  onTap: () {
                    // Navigate to Upcoming Auction screen
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(Icons.shop, size: 40, color: Colors.blue),
                        SizedBox(height: 10),
                        Text(
                          'Odder 1',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Items 3',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Live Auction
            Expanded(
              child: Card(
                elevation: 4.0,
                child: InkWell(
                  onTap: () {
                    // Navigate to Live Auction screen
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(Icons.production_quantity_limits,
                            size: 40, color: Colors.red),
                        SizedBox(height: 10),
                        Text(
                          'Order 2',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Items 3',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
