import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/inventory/add_inventory/attribute/attribute_inventory_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


 class AttributeController extends GetxController {
  var isLoading = false.obs;
  var attributes = <AttributeModel>[].obs;
  var commission = 0.obs; // Observable to hold the commission value

  late TextEditingController commissionController;

  @override
  void onInit() {
    super.onInit();
    commissionController = TextEditingController(); // Initialize the controller
  }

  Future<void> fetchAttributes(int productId) async {
    isLoading.value = true;

    final url =
        Uri.parse('${AppURL.baseURL}api/products/$productId/attributes');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Parse the response into the new model
        final attributeResponse = AttributeResponse.fromJson(data);

        // Update attributes and commission
        attributes.value = attributeResponse.formattedAttributes;
        commission.value = attributeResponse.commission;

        // Update the commission in the controller
        commissionController.text = attributeResponse.commission.toString();
      } else {
        Get.snackbar('Error', 'Failed to fetch attributes',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
