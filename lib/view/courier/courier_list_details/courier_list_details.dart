import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/view/courier/courier_list_details/courier_list_details_controller.dart';
import 'package:isotopeit_b2b/view/courier/courier_list_details/courier_list_details_model.dart';
import 'package:isotopeit_b2b/utils/color.dart';

class CourierDetails extends StatelessWidget {
  final CourierDetailController controller = Get.put(CourierDetailController());

  CourierDetails({super.key});

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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.courierData.value == null) {
          return const Center(child: Text("No Details Available"));
        }

        final courier = controller.courierData.value!;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildDetailRow('Order Number:', courier.orderNumber),
                _buildDetailRow('Tracking Number:', courier.trackNo),
                _buildDetailRow('Customer Name:', courier.customerName),
                const SizedBox(height: 25),
                _buildDetailRow('Status:', courier.status, isValueBordered:true, valueColor: Colors.green),
                const SizedBox(height: 25),
                DottedLine(
                dashColor: Colors.black.withOpacity(0.2),
              ),
                const SizedBox(height: 25),
                const Text(
                  'Order Items Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ...courier.orderItems
                    .map((item) => orderItemInfo(item))
                    .toList(),
                const SizedBox(height: 25),
                DottedLine(
                dashColor: Colors.black.withOpacity(0.2), 
              ),
               const SizedBox(height: 25),
                _buildDetailRow('Vehicle Charge:', courier.vehicleCharge),
                _buildDetailRow(
                    'Load Unload Charge:', courier.loadUnloadCharge),
                _buildDetailRow('Grand Total:', courier.grandTotal),
                 const SizedBox(height: 25),
                DottedLine(
                  dashColor: Colors.black.withOpacity(0.2),
                ),
                const SizedBox(height: 25),
                _buildDetailRow('Payment Amount:', courier.paymentAmount, color: Colors.green ),
                _buildDetailRow('Due:', courier.due, color: Colors.red),
              ],
            ),
          ),
        );
      }),
    );
  }

  Card orderItemInfo(OrderItem item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(item.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemDescription,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('Quantity: ${item.quantity}'),
                  Text('Price: ৳ ${item.unitPrice}'),
                ],
              ),
            ),
            Text(
              '৳${item.totalPrice}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value,
      {Color? color, Color? valueColor,  bool isValueBordered = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: isValueBordered
                ? BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green.withOpacity(0.2)
                  )
                : null,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
