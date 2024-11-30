import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/order/order_details/controller_order_details.dart';

class OrderDetails extends StatelessWidget {
  final int orderId;
  final OrderDetailsController orderController =
      Get.put(OrderDetailsController());

  OrderDetails({required this.orderId, super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch order details using the passed orderId
    orderController.fetchOrderDetails(orderId);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final order = orderController.orderDetails.value.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildDetailRow('Order Number:', order.orderNumber ?? 'N/A'),
                // _buildDetailRow('Customer Email:', order.customerEmail ?? 'N/A'),
                // _buildDetailRow('Customer Phone:', order.customerPhoneNumber ??  'N/A'),

                // _buildDetailRow('Total Amount:', '${order.total} tk'),
                // _buildDetailRow('Total Amount:',
                //     '${double.parse(order.total).toStringAsFixed(2)} tk'),
                _buildDetailRow(
                  'Total Amount:',
                  '${double.tryParse(order.total!.replaceAll(',', '').trim())?.toStringAsFixed(2) ?? '0.00'} tk',
                ),
                // _buildDetailRow('Tax:',
                //     '${double.parse(order.taxes).toStringAsFixed(2)} tk'),
                // _buildDetailRow(
                //   'Tax:',
                //   '${double.tryParse(order.taxes?.replaceAll(',', '').trim() ?? '0')?.toStringAsFixed(2) ?? '0.00'} tk',
                // ),
                _buildDetailRow(
                    'Payment Status:', order.paymentStatus ? 'Paid' : 'Unpaid'),
                // _buildDetailRow('Grand Total:',
                //     '${double.parse(order.grandTotal).toStringAsFixed(2)} tk',
                //     color: Colors.green),
                _buildDetailRow(
                  'Grand Total:',
                  '${double.tryParse(order.grandTotal?.replaceAll(',', '').trim() ?? '0')?.toStringAsFixed(2) ?? '0.00'} tk',
                  color: Colors.green,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Order Items',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: order.items.length,
                    itemBuilder: (context, index) {
                      final item = order.items[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: const Icon(Icons.shopping_cart),
                          title: Text(item.itemDescription),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quantity: ${item.quantity}',
                              ),
                              Text(
                                'Total: ${item.totalAmount} tk',
                              ),
                            ],
                          ),
                          trailing: Chip(
                            label: const Text('Approved'),
                            backgroundColor: Colors.green.shade100,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildDetailRow(String title, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(width: 15),
          Text(value, style: TextStyle(fontSize: 16, color: color)),
        ],
      ),
    );
  }

  // Assuming _buildDetailRow is defined as follows:
  Widget _buildDetailRowStatus(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          value,
        ),
      ],
    );
  }
}
