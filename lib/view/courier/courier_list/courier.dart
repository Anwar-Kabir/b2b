


 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/courier/courier_list_details/courier_list_details.dart';
import 'package:isotopeit_b2b/view/courier/courier_list/courier_list_controller.dart';

class Courier extends StatelessWidget {
  final CourierController controller = Get.put(CourierController());

  Courier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Courier List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.couriers.isEmpty) {
          return const Center(child: Text("No Couriers Available"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: controller.couriers.length,
          itemBuilder: (context, index) {
            final courier = controller.couriers[index];
             //final courierID = controller.couriers[index].id;
            final totalItems = courier.orderItems.length;
            final totalPrice = courier.orderItems
                .map((item) => double.parse(item.price))
                .reduce((a, b) => a + b);

            return GestureDetector(
             
              onTap: () {
                
                Get.to(  CourierDetails(),
                    transition: Transition.rightToLeftWithFade);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.grey, width: 2),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TN #${courier.trackNo}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(courier.createdAt),
                          const SizedBox(height: 4),
                          Text(
                              '$totalItems Items, Total \$${totalPrice.toStringAsFixed(2)}'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 12),
                          Chip(
                            label: const Text(
                              'Shipped',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            padding: const EdgeInsets.all(12),
                            backgroundColor: Colors.green.withOpacity(0.2),
                          ),
                          const SizedBox(height: 8),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
