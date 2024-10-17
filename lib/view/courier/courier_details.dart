

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/utils/color.dart';

class CourierDetails extends StatelessWidget {
  const CourierDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Courier Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildDetailRow('Order Number:', '191101'),
              _buildDetailRow('Tracking Number:', '05-Oct-2024'),
              _buildDetailRow('Customer Name:', 'Harun Ahmed'),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Aligns children within available space
                children: [
                  const Text(
                    "Status",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Chip(
                    label: const Text(
                      'Shipped',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.all(8),
                    backgroundColor: Colors.green.withOpacity(0.2),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              DottedLine(
                dashColor: Colors.black.withOpacity(0.2),
              ),
              const SizedBox(height: 25),
              const Text(
                'Order Items Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              orderItemInfo(),
              const SizedBox(height: 8),
              orderItemInfo(),
              const SizedBox(height: 8),
              orderItemInfo(),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, // Makes column fill width
                children: [
                  _buildDetailRow('Vehicle Charge:', '2,000.00'),
                  _buildDetailRow('Sub Total:', '3,400.00'),
                  _buildDetailRow('Load Unload Charge:', '200.00'),
                  _buildDetailRow('Grand Total:', '5,998.65'),
                  const SizedBox(height: 8),
                  DottedLine(dashColor: Colors.black.withOpacity(0.2)),
                  const SizedBox(height: 8),
                  _buildDetailRow('Payment:', '1,249.22', color: Colors.green),
                  _buildDetailRow('Due:', '4,749.43', color: Colors.red),
                ],
              ),
              const SizedBox(height: 25),
              DottedLine(dashColor: Colors.black.withOpacity(0.2)),
              const SizedBox(height: 25),
              const Text(
                'Progress/Delivery Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildStatusCard(
                title: 'Expected',
                details: [
                  'Pickup: 12-12-2024',
                  'Delivery: 12-12-2024',
                ],
              ),
              buildStatusCard(
                title: 'Pickup',
                details: [
                  'Time: 12-12-2024',
                  'User: Rabbi Ahamed',
                ],
              ),
              buildStatusCard(
                title: 'Shipped',
                details: [
                  'Time: 12-12-2024',
                  'User: Rabbi Ahamed',
                ],
              ),
              buildStatusCard(
                title: 'Generate',
                details: [
                  'Time: 12-12-2024',
                  'User: Rabbi Ahamed',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card orderItemInfo() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Image on the left
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                  image: AssetImage('assets/abc.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Product details
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Korola Bitter Gourd",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Quantity: 6',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text('Price: \$174.65'),
                ],
              ),
            ),

            // Price section
            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 25),
                Text(
                  '\$1046.65',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
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
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Aligns title and value
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatusCard(
      {required String title, required List<String> details}) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              for (String detail in details) Text(detail),
            ],
          ),
        ),
      ),
    );
  }
}
