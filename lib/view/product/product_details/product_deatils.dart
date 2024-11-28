import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/view/product/product_details/controller_product_details.dart'; // Import GetX

class ProductDetailsPage extends StatelessWidget {
  final int productId;
  final ProductDetailsController productController =
      Get.put(ProductDetailsController());

  ProductDetailsPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch product on init using the controller
    productController.fetchProduct(productId);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        // Use Obx to reactively listen to changes
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (productController.errorMessage.isNotEmpty) {
          return Center(child: Text(productController.errorMessage.value));
        } else if (productController.product.value == null) {
          return const Center(child: Text('No product data available'));
        } else {
          final product = productController.product.value!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  if (product.featureImage != null &&
                      product.featureImage!.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Border color for the image
                          width: 2.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          product.featureImage!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors
                              .grey, // Border color for the default asset image
                          width: 2.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image(
                          image: AssetImage(AppImages.splashLogo),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                      "Min order quantity:", "${product.minOrderQuantity}"),
                  _buildDetailRow("HS Code:", "${product.hsCode ?? 'N/A'}"),

                  // Status row added here
                  _buildStatusRow(
                      product.category.isActive), // Adjusted status row
                  _buildDetailRow("Last Update:",
                      _formatDate(product.updatedAt)), // Format date

                  const SizedBox(
                    height: 15,
                  ),

                  // Add tabs for Basic Info and Description after the status row
                  DefaultTabController(
                    length: 2, // Number of tabs
                    child: Column(
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(text: "Basic Info"),
                            Tab(text: "Description"),
                          ],
                        ),
                        SizedBox(
                          height: 200, // Adjust height as needed
                          child: TabBarView(
                            children: [
                              // Basic Info Tab
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailRow("Min order quantity:",
                                        "${product.minOrderQuantity}"),
                                    _buildDetailRow("HS Code:",
                                        "${product.hsCode ?? 'N/A'}"),
                                  ],
                                ),
                              ),
                              // Description Tab
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    product.description,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Status:",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: isActive ? Colors.green : Colors.red,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              isActive ? "Active" : "Inactive",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    // Parse the date string and format it
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('MMM dd, yyyy, h.mm a')
        .format(dateTime); // Updated format
  }
}
