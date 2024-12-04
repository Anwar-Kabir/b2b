import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/product/productlist/model_product_list.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    isLoading(true);
    update(); // Show circular progress indicator

    final url = Uri.parse(AppURL.productList);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ensure that we retrieve a non-null token
    final token = prefs.getString('token') ??
        ''; // Assign an empty string if the token is null

    // If the token is still empty, handle it appropriately
    if (token.isEmpty) {
      Get.snackbar(
        'Error',
        'Token is missing or invalid. Please log in again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading(false);
      update();
      return;
    }

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    debugPrint("Token used: $token");

    try {
      final response = await http.get(url, headers: headers);

      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Product> loadedProducts = [];

        // Parse the JSON data and convert it to Product objects
        for (var productData in jsonData['data']) {
          loadedProducts.add(Product.fromJson(productData));
        }

        // Update the productList with fetched data
        productList.assignAll(loadedProducts);

        // Get.snackbar(
        //   'Success',
        //   'Products loaded successfully.',
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        //   snackPosition: SnackPosition.BOTTOM,
        // );
      } else {
        // Handle non-200 response
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          errorData['message'] ??
              'Failed to load products. Status: ${response.statusCode}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Log the error message for debugging
      debugPrint("Error occurred: $e");

      Get.snackbar(
        'Error',
        'An error occurred while fetching data: $e', // Display the error message
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
      update(); // Hide loading spinner
    }
  }
}
