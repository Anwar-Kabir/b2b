// supplier_order_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/order_report/order_report_controller_dart';
import 'package:isotopeit_b2b/view/order_report/order_report_model.dart';
 

class SupplierOrderScreen extends StatefulWidget {
  @override
  _SupplierOrderScreenState createState() => _SupplierOrderScreenState();
}

class _SupplierOrderScreenState extends State<SupplierOrderScreen> {
  final SupplierOrderController controller = Get.put(SupplierOrderController());
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  void _submit() {
    if (startDate != null && endDate != null) {
      controller.fetchSupplierOrders(
        startDate!.toIso8601String(),
        endDate!.toIso8601String(),
      );
    } else {
      Get.snackbar('Error', 'Please select both start and end dates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Report',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Start Date"),
                    Text(startDate != null
                        ? startDate!.toLocal().toString().split(' ')[0]
                        : " "),
                    ElevatedButton(
                      onPressed: () => _selectStartDate(context),
                      child: Text("Pick Start Date"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("End Date"),
                    Text(endDate != null
                        ? endDate!.toLocal().toString().split(' ')[0]
                        : " "),
                    ElevatedButton(
                      onPressed: () => _selectEndDate(context),
                      child: Text("Pick End Date"),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text("Submit"),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.orders.isEmpty) {
                  return Center(child: Text("No orders report found"));
                }
                return ListView.builder(
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    SupplierOrder order = controller.orders[index];
                    return ListTile(
                      title: Text(order.categoryName),
                      subtitle: Text(order.itemDescription),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Quantity: ${order.quantity}"),
                          Text("Total: ${order.totalAmount}"),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
