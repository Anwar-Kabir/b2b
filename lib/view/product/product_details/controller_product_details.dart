import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/view/product/product_details/model_product_details.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsController extends GetxController {
  final String baseUrl = "https://e-commerce.isotopeit.com/api/product/";

  // Reactive state variables
  var product = Rx<Product?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Fetch product by ID and handle all state internally
  Future<void> fetchProduct(int productId) async {
    _setLoading(true);
    _setErrorMessage('');

    try {
      // Retrieve token from shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Ensure that we retrieve a non-null token
      final token = prefs.getString('token') ?? ''; 

      if (token == null || token.isEmpty) {
        throw Exception('No token found');
      }

      final url = Uri.parse('$baseUrl$productId/show');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        _setProduct(Product.fromJson(jsonResponse));
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token.');
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } on SocketException {
      _setErrorMessage('No internet connection.');
    } on FormatException {
      _setErrorMessage('Invalid response format.');
    } catch (e) {
      _setErrorMessage('Error fetching product: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Internal methods to set state
  void _setLoading(bool value) {
    isLoading.value = value; // Update the reactive variable
  }

  void _setProduct(Product? productValue) {
    product.value = productValue; // Update the reactive variable
  }

  void _setErrorMessage(String message) {
    errorMessage.value = message; // Update the reactive variable
  }
}
