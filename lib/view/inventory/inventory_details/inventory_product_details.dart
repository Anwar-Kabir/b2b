// inven_product_details.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/view/inventory/inventory_details/inventory_details_controller.dart';
import 'package:isotopeit_b2b/view/inventory/inventory_details/inventory_product_details_model.dart';
import 'package:isotopeit_b2b/view/inventory/inventrory/inventory_controller.dart';
import 'package:isotopeit_b2b/view/inventory/update_inventory/update_inventory.dart';

class InvenProductDetails extends StatelessWidget {
  final int inventoryId;
  final InventoryDetailController controller =
      Get.put(InventoryDetailController());

  InvenProductDetails({super.key, required this.inventoryId});

  @override
  Widget build(BuildContext context) {
    controller.fetchInventoryDetail(inventoryId);
     int? productid;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.hasError.value ||
            controller.inventoryDetail.value == null) {
          return const Center(child: Text('Failed to load inventory details'));
        }

        final InventoryDetailModel product = controller.inventoryDetail.value!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: product.images != null && product.images!.isNotEmpty
                        ? Image.network(
                            product
                                .images![0].url, // Access the first image's URL
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fitHeight,
                          )
                        : Image.asset(
                            AppImages.splashLogo, // Default asset image
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),

              // Center(
              //   child: Image.network(
              //     product.images.isNotEmpty
              //         ? product.images[0].url
              //         : 'https://via.placeholder.com/150',
              //     height: 200,
              //     width: 200,
              //   ),
              // ),
              const SizedBox(height: 10),
              // SizedBox(
              //   height: 80,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: product.images.map((image) {
              //       return _buildImageSelection(image.url);
              //     }).toList(),
              //   ),
              // ),
              const SizedBox(height: 20),
              Text(product.productName,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('${product.salePrice} tk',
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('Additional Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildDetailRow('SKU', product.sku),
              _buildDetailRow(
              'Stock Quantity', '${product.stockQuantity.toString()}  '),
             
              ...product.attributes
                  .map((attr) => _buildDetailRow(attr.name,
                      attr.values.map((val) => val.value).join(', ')))
                  .toList(),
              const SizedBox(height: 20),
              const Text('Description',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(product.description ?? 'No description available.',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  //  Get.to(UpdateInventory(productID: productid),
                  //     transition: Transition.rightToLeftWithFade);
                },
                child: const Text('Edit'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _showDeleteConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child:
                    const Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text(
              'Are you sure you want to delete this inventory item? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close the dialog first

                // Show loading indicator
                Get.dialog(const Center(child: CircularProgressIndicator()));

                bool success =
                    await controller.deleteInventoryItem(inventoryId);

                // Close the loading indicator
                Get.back(); // Close the CircularProgressIndicator

                if (success) {
                  Get.back(); // Navigate back to the inventory list
                  

                 Get.snackbar(
                    "Success",
                    'Inventory item deleted successfully.',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(10),
                    borderRadius: 8,
                    duration: const Duration(seconds: 3),
                  );     

                  // Notify the inventory list to refresh
                  // Assuming you're using GetX, you can do this by calling a method in the inventory list controller
                  // For example:
                  Get.find<InventoryActiveController>()
                      .fetchActiveProducts(); // Adjust this line based on your controller setup
                  Get.find<InventoryActiveController>().fetchInactiveProducts();
                  Get.find<InventoryActiveController>().fetchInStockProducts();
                  Get.find<InventoryActiveController>()
                      .fetchOutOfStockProducts();
                } else {
                  Get.snackbar('Error', 'Failed to delete inventory item.');
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImageSelection(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.network(imageUrl, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(width: 15),
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
