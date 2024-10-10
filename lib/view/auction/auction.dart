import 'package:flutter/material.dart';

class Auction {
  final String id;
  final String productName;
  final double startingPrice;
  final DateTime startTime;
  final DateTime endTime;
  List<Bid> bids;

  Auction({
    required this.id,
    required this.productName,
    required this.startingPrice,
    required this.startTime,
    required this.endTime,
    this.bids = const [],
  });

  bool get isOngoing => DateTime.now().isBefore(endTime);
}

class Bid {
  final String bidderName;
  final double bidAmount;
  final DateTime bidTime;

  Bid({
    required this.bidderName,
    required this.bidAmount,
    required this.bidTime,
  });
}


class AuctionManager extends StatefulWidget {
  @override
  _AuctionManagerState createState() => _AuctionManagerState();
}

class _AuctionManagerState extends State<AuctionManager> {
  List<Auction> auctions = [];

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController startingPriceController = TextEditingController();
  final TextEditingController bidderNameController = TextEditingController();
  final TextEditingController bidAmountController = TextEditingController();

  void createAuction() {
    String productName = productNameController.text;
    double startingPrice = double.tryParse(startingPriceController.text) ?? 0;
    DateTime startTime = DateTime.now();
    DateTime endTime = startTime.add(Duration(hours: 1)); // 1 hour auction

    if (productName.isNotEmpty && startingPrice > 0) {
      setState(() {
        auctions.add(Auction(
          id: DateTime.now().toString(),
          productName: productName,
          startingPrice: startingPrice,
          startTime: startTime,
          endTime: endTime,
        ));
      });
      productNameController.clear();
      startingPriceController.clear();
    }
  }

  void placeBid(Auction auction) {
    String bidderName = bidderNameController.text;
    double bidAmount = double.tryParse(bidAmountController.text) ?? 0;

    if (bidderName.isNotEmpty && bidAmount > auction.startingPrice) {
      setState(() {
        auction.bids.add(Bid(
          bidderName: bidderName,
          bidAmount: bidAmount,
          bidTime: DateTime.now(),
        ));
      });
      bidderNameController.clear();
      bidAmountController.clear();
    }
  }

  void showBidDialog(Auction auction) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Place Bid for ${auction.productName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: bidderNameController,
                decoration: InputDecoration(labelText: 'Your Name'),
              ),
              TextField(
                controller: bidAmountController,
                decoration: InputDecoration(labelText: 'Bid Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                placeBid(auction);
                Navigator.of(context).pop();
              },
              child: Text('Submit Bid'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auction Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create New Auction:', style: TextStyle(fontSize: 18)),
            TextField(
              controller: productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: startingPriceController,
              decoration: InputDecoration(labelText: 'Starting Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: createAuction,
                child: Text('Create Auction'),
              ),
            ),
            SizedBox(height: 20),
            Text('Ongoing Auctions:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: auctions.length,
                itemBuilder: (context, index) {
                  final auction = auctions[index];
                  return Card(
                    child: ListTile(
                      title: Text(auction.productName),
                      subtitle: Text(
                        'Starting Price: \$${auction.startingPrice.toStringAsFixed(2)}\n'
                        'End Time: ${auction.endTime}\n'
                        'Status: ${auction.isOngoing ? "Ongoing" : "Ended"}',
                      ),
                      trailing: auction.isOngoing
                          ? IconButton(
                              icon: Icon(Icons.shop),
                              onPressed: () => showBidDialog(auction),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


