


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/order/order_details/order_deatils.dart';
import 'package:isotopeit_b2b/view/order/orderlist/controller_order_list.dart';

class OrderListScreen extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

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
      body: Obx(() {
        if (orderController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (orderController.orderList.isEmpty) {
          return Center(child: Text('No orders found.'));
        } else {
          return ListView.builder(
            itemCount: orderController.orderList.length,
            itemBuilder: (context, index) {
              var order = orderController.orderList[index];
              return GestureDetector(
                onTap: () {
                  var id = order.id;
                  Get.to(() => OrderDetails(orderId: id),
                      transition: Transition.rightToLeftWithFade);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Order details
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order #${order.orderNumber}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              // Text(order.createdAt.toLocal().toString()),
                              Text(
                                DateFormat('MMM dd, yyyy, h:mm a')
                                    .format(order.createdAt.toLocal()),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${order.itemCount} Items, Grand Total ৳ ${double.parse(order.grandTotal).toStringAsFixed(2)}',
                              ),
                            ],
                          ),
                          // Status Chips
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 35,
                                child: Chip(
                                  label: Text(order.orderStatus == 1
                                      ? 'Approved'
                                      : 'Pending'),
                                  backgroundColor: order.orderStatus == 1
                                      ? Colors.green.shade100
                                      : Colors.orange.shade100,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 35,
                                child: Chip(
                                  label: Text(order.paymentStatus == 1
                                      ? 'Paid'
                                      : 'Unpaid'),
                                  backgroundColor: order.paymentStatus == 1
                                      ? Colors.green.shade100
                                      : Colors.red.shade100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
