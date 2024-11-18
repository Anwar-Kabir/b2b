import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:isotopeit_b2b/view/auction/auction_details.dart';
import 'package:isotopeit_b2b/view/auction/auction_live/auction_live_model.dart';

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
                //Text("UUID: ${auction.uuid}"),
               // Text("Auction Date: ${auction.auctionDate}"),
                Text(
                  "Auction Date: ${DateFormat('MMM dd, yyyy, hh:mm a').format(DateTime.parse(auction.auctionDate))}",
                ),
                Text("Pre-deposit: ${auction.preDepositePercentage}%"),
                Text("Highest Bid: ${auction.highestBid}"),
                Text("Bid Increment: ${auction.bidIncrement}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
