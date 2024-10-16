import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/utils/color.dart';

class OrderDeatils extends StatelessWidget {
  const OrderDeatils({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Deatils",
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildDetailRow('Order Number:', '191101'),
            _buildDetailRow('Date:', '05-Oct-2024'),
            _buildDetailRow('Order Status:', 'Unpaid'),
            _buildDetailRow('Total Amount:', '6822 tk'),
            _buildDetailRow('Delivery Cost:', '300'),
            _buildDetailRow('Grand Total:', '96555', color: Colors.green),
            _buildDetailRow('Payment:', '2000'),
            _buildDetailRow('Due:', '6000', color: Colors.red),
            const SizedBox(height: 20),
            DottedLine(
              dashColor: Colors.black.withOpacity(0.2),
            ),
            const SizedBox(height: 20),
            const Text('Order Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            GestureDetector(
              onDoubleTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildBottomSheetContent();
                  },
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Aligns items to the top
                    children: <Widget>[
                      // Image on the left (leading)
                      Container(
                        width: 80, // Set the width of the image
                        height: 80, // Set the height of the image
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10.0), // Rounded image corners
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/abc.jpg'), // Local asset image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Space between image and text
                      const SizedBox(width: 12),

                      // Product details
                      const Expanded(
                        // Makes sure text occupies the remaining space
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Product name
                            Text(
                              "Korola Bitter Gourd",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            SizedBox(
                                height:
                                    6), // Space between product name and price

                            // Price details
                            Text(
                              '2 Items, Total Amount\$23',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            // Text(
                            //   'Price: \$85.0',
                            //   style: TextStyle(color: AppColor.primaryColor),
                            // ),
                            Text('Net Price: \$92.65'),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Chip(
                            padding: const EdgeInsets.all(2),
                            labelPadding: const EdgeInsets.all(1),
                            label: const Text('Approved'),
                            backgroundColor: Colors.green.shade100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(
            width: 15,
          ),
          Text(value, style: TextStyle(fontSize: 16, color: color)),
        ],
      ),
    );
  }

  // Bottom sheet content
  Widget _buildBottomSheetContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("Order Item Details:"),

          const SizedBox(height: 8),

          const Text(
            'Item: 124553: Kacha Morich (Green Chilly) - Large - Local - Green',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // const Text(
          //   '',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 8),

          const Text("Quantity: 8pcs"),

          const SizedBox(height: 8),

          const Text("Unite Price: 12 tk"),

          const SizedBox(height: 8),

          const Text("Total Amount: 92 tk"),

          const SizedBox(height: 16),

          // Address field (use a dropdown or regular text input)

          TextFormField(
            initialValue: '#H 90, #R 19, Merul, Dhaka',
            decoration: const InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Status field with button options

          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                onPressed: () {
                  // Handle approve action
                },
                child: const Text('Approve'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red, // Set the text color to white
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12), // Add padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                onPressed: () {
                  // Handle reject action
                },
                child: const Text('Reject'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
