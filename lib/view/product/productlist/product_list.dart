import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/view/product/product_details/product_deatils.dart';
import 'package:isotopeit_b2b/view/product/productlist/controller_product_list.dart';

class ProductListCard extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          // Show circular progress indicator while loading
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (productController.productList.isEmpty) {
          return const Center(child: Text('No products available.'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: productController.productList.length,
              itemBuilder: (context, index) {
                final product = productController.productList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to product details (can be implemented later)
                    Get.to(() => ProductDetailsPage(productId: product.id),
                        transition: Transition.rightToLeftWithFade);
                  },
                  child: SizedBox(
                    height: 110,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: product.featureImage != null &&
                                          product.featureImage!.isNotEmpty
                                      ? NetworkImage(product.featureImage!)
                                      : AssetImage(AppImages.splashLogo)
                                          as ImageProvider, // Use asset image if URL is null or empty
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    product.name ??
                                        'No product name found', // Use a fallback message
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    product.subSubCategory ??
                                        'No sub-category found', // Handle null for sub-category
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
