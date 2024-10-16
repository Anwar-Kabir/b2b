import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/wallet/wallet_request_details.dart';
import 'package:isotopeit_b2b/view/wallet/wallet_request_money.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  // Example data
  final List<Map<String, dynamic>> requests = [
    {
      'requestedBy': 'Pykari.com',
      'requestedAt': '01-10-2024 15:20',
      'amount': 1000.00,
      'status': 'Rejected',
    },
    {
      'requestedBy': 'Pykari.com',
      'requestedAt': '01-10-2024 15:21',
      'amount': 999.00,
      'status': 'Approved',
    },
    {
      'requestedBy': 'Pykari.com',
      'requestedAt': '15-10-2024 11:56',
      'amount': 1000.00,
      'status': 'Pending',
    },
  ];

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
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return GestureDetector(
            onTap: () {
              Get.to(const RequestDetails(),
                  transition: Transition.rightToLeftWithFade);
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Requested By: ${request['requestedBy']}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text('Requested At: ${request['requestedAt']}'),
                        const SizedBox(height: 5),
                        Text(
                            'Amount: \$${request['amount'].toStringAsFixed(2)}'),
                        const SizedBox(height: 10),
                      ],
                    ),
                    StatusBadge(status: request['status']),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    if (status == 'Approved') {
      bgColor = Colors.green;
    } else if (status == 'Rejected') {
      bgColor = Colors.red;
    } else if (status == 'Pending') {
      bgColor = Colors.orange;
    } else {
      bgColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
