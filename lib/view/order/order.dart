import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/order/order_deatils.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Order List',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColor.primaryColor.withOpacity(0.7),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 110,
              child: GestureDetector(
                onTap: () {
                  Get.to(const OrderDeatils(),
                      transition: Transition.rightToLeftWithFade);
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        // Add border color and width
                        color: Colors.grey, // Change this to your desired color
                        width: 2, // Set the border width
                      ),
                    ),
                    elevation: 4,
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Order Details
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order #123',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text('23 Jan, 2023'),
                                SizedBox(height: 4),
                                Text('2 Items, Total \$23'),
                              ],
                            ),

                            // Status Chips
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 35,
                                  child: Chip(
                                    label: const Text('Approved'),
                                    padding: const EdgeInsets.all(2),
                                    labelPadding: const EdgeInsets.all(1),
                                    backgroundColor: Colors.green.shade100,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 35,
                                  child: Chip(
                                    padding: const EdgeInsets.all(2),
                                    labelPadding: const EdgeInsets.all(1),
                                    label: const Text('Unpaid'),
                                    backgroundColor: Colors.red.shade100,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ))),
              ),
            )));
  }
}
