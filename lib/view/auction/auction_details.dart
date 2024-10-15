import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/utils/color.dart';

class AuctionDetails extends StatelessWidget {
  const AuctionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Auction Details',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColor.primaryColor.withOpacity(0.7),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               
               Center(
                 child: Container(
                  width: 150, // Set the width of the image
                  height: 150, // Set the height of the image
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded image corners
                    image: const DecorationImage(
                      image: AssetImage('assets/abc.jpg'), // Local asset image
                      fit: BoxFit.cover,
                    ),
                  ),
                               ),
               ),

                 const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  
                  
                  // Product Information
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text('Name: Stripe Floor Mat',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('Status: Active'),
                        SizedBox(height: 8),
                        Text('Available from: 2024-10-17 20:33:00'),
                        SizedBox(height: 8),
                        Text('Last update: Tue, Oct 8, 2024 1:58 AM'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // TabBar
              const TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: 'Listing'),
                  Tab(text: 'Product'),
                  Tab(text: 'Description'),
                  Tab(text: 'Auction'),
                  Tab(text: 'Images'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    // Listing Tab
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SKU: Facilis nisi culpa q'),
                          SizedBox(height: 8),
                          Text('Base Price: 511'),
                          SizedBox(height: 8),
                          Text('Stock quantity: 413'),
                        ],
                      ),
                    ),
                    // Product Tab (You can customize this)
                    Center(child: Text('Product details go here')),
                    // Description Tab (You can customize this)
                    Center(child: Text('Description of the product goes here')),
                    // Auction Tab (You can customize this)
                    Center(child: Text('Auction details go here')),
                    // Images Tab (You can customize this)
                    Center(child: Text('Product images go here')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
