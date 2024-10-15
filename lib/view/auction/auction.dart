import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/auction/add_auction.dart';
import 'package:isotopeit_b2b/view/auction/auction_details.dart';

class AuctionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Auction',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColor.primaryColor.withOpacity(0.7),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                Get.to(AddAuction(),
                    transition: Transition.rightToLeftWithFade);
              },
              label: const Text(
                "Add Auction",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white, // Color for selected tab
            unselectedLabelColor: Colors.grey, // Color for unselected tabs
            indicatorColor: AppColor.primaryColor, // Color of the indicator below the tab
            tabs: [
              const Tab(text: "Upcoming", ),
              Tab(text: "Live"),
              Tab(text: "Closed"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AuctionList(auctionData: upcomingAuctions),
            AuctionList(auctionData: liveAuctions),
            AuctionList(auctionData: closedAuctions),
          ],
        ),
      ),
    );
  }
}

class AuctionList extends StatelessWidget {
  final List<Map<String, dynamic>> auctionData;

  AuctionList({required this.auctionData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: auctionData.length,
      itemBuilder: (context, index) {
        final auction = auctionData[index];
        return GestureDetector(
          onTap: (){
            Get.to(const AuctionDetails(), transition: Transition.rightToLeftWithFade);
          },
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Auction No: ${auction['auctionNo']}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("SKU: ${auction['sku']}"),
                  Text("Product Name: ${auction['productName']}"),
                  Text("Base Price: \$${auction['basePrice']}"),
                  Text("Quantity: ${auction['quantity']}"),
                  Text("Auction Date: ${auction['auctionDate']}"),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Sample Data for Testing
final List<Map<String, dynamic>> upcomingAuctions = [
  {
    'auctionNo': 'AUC00000001',
    'sku': 'Facilis nisi culpa q',
    'productName': 'Stripe Floor Mat',
    'basePrice': 511.00,
    'quantity': 413,
    'auctionDate': '2024-10-17 20:33:00'
  },
  {
    'auctionNo': 'AUC00000002',
    'sku': 'Quis voluptates dolo',
    'productName': 'NG Opal Plate 10.75 Inch',
    'basePrice': 518.00,
    'quantity': 118,
    'auctionDate': '2024-10-17 10:34:00'
  },
  {
    'auctionNo': 'AUC00000003',
    'sku': 'werwqerqwe',
    'productName': 'Watermelon',
    'basePrice': 10000.00,
    'quantity': 100,
    'auctionDate': '2024-10-15 11:32:00'
  },
];

final List<Map<String, dynamic>> liveAuctions = [
  // Live auction data
    {
    'auctionNo': 'AUC00000001 live',
    'sku': 'Facilis nisi culpa q',
    'productName': 'Stripe Floor Mat',
    'basePrice': 511.00,
    'quantity': 413,
    'auctionDate': '2024-10-17 20:33:00'
  },
  {
    'auctionNo': 'AUC00000002',
    'sku': 'Quis voluptates dolo',
    'productName': 'NG Opal Plate 10.75 Inch',
    'basePrice': 518.00,
    'quantity': 118,
    'auctionDate': '2024-10-17 10:34:00'
  },
];

final List<Map<String, dynamic>> closedAuctions = [
  // Closed auction data
    {
    'auctionNo': 'AUC00000001 closed',
    'sku': 'Facilis nisi culpa q',
    'productName': 'Stripe Floor Mat',
    'basePrice': 511.00,
    'quantity': 413,
    'auctionDate': '2024-10-17 20:33:00'
  },
  {
    'auctionNo': 'AUC00000002',
    'sku': 'Quis voluptates dolo',
    'productName': 'NG Opal Plate 10.75 Inch',
    'basePrice': 518.00,
    'quantity': 118,
    'auctionDate': '2024-10-17 10:34:00'
  },
];
