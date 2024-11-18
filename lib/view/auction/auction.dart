import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/auction/auction_live/auction_live_controller.dart';
import 'package:isotopeit_b2b/view/auction/auction_live/auction_live_model.dart';
 


 class AuctionPage extends StatelessWidget {
  AuctionPage({Key? key}) : super(key: key);

  final AuctionController auctionController = Get.put(AuctionController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Auction', style: TextStyle(color: Colors.white)),
           backgroundColor: AppColor.primaryColor.withOpacity(0.7),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            TextButton.icon(
              onPressed: () {
                Get.toNamed('/add-auction'); // Navigate to Add Auction Page
              },
              label: const Text("Add Auction",
                  style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Upcoming"),
              Tab(text: "Live"),
              Tab(text: "Closed"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const AuctionList(auctionData: []), // Replace with actual data
            Obx(() {
              if (auctionController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return AuctionList(auctionData: auctionController.liveAuctions);
            }),
            const AuctionList(auctionData: []), // Replace with actual data
          ],
        ),
      ),
    );
  }
}

// Auction List Widget
class AuctionList extends StatelessWidget {
  final List<Auction> auctionData;

  const AuctionList({Key? key, required this.auctionData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (auctionData.isEmpty) {
      return const Center(child: Text('No auctions available.'));
    }
    return ListView.builder(
      itemCount: auctionData.length,
      itemBuilder: (context, index) {
        final auction = auctionData[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Auction No: ${auction.auctionNumber}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("UUID: ${auction.uuid}"),
                Text("Auction Date: ${auction.auctionDate}"),
                Text("Pre-deposit: ${auction.preDepositePercentage}%"),
                Text("Highest Bid: ${auction.highestBid}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
