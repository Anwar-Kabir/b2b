import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/courier/courier_details.dart';

class Courier extends StatelessWidget {
  const Courier({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Courier List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 110,
                child: GestureDetector(
                  onTap: () {
                    Get.to(const CourierDetails(),
                        transition: Transition.rightToLeftWithFade);
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          // Add border color and width
                          color:
                              Colors.grey, // Change this to your desired color
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
                                    'TN #123',
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
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Chip(
                                    label: const Text(
                                      'Shipped',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    labelPadding: const EdgeInsets.all(1),
                                    backgroundColor:
                                        Colors.green.withOpacity(0.2),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              )
                            ],
                          ))),
                ),
              ))
        ],
      ),
    );
  }
}
