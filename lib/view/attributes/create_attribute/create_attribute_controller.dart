import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/attributes/attribute_list/attribute.dart';
import 'package:isotopeit_b2b/view/attributes/attribute_list/attribute_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateAttributeController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController orderController = TextEditingController();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter attribute name';
    }
    return null;
  }

  String? validateOrder(String? value) {
    if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
      return 'Please enter a valid order number';
    }
    return null;
  }

  Future<void> createAttribute({
    required String name,
    required int order,
    required List<String> categories,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    // Define API URL
    const url = '${AppURL.baseURL}api/attribute';

    try {
      isLoading(true);
      print('API Call Started: $url');

      // Construct the request body
      final requestBody = {
        'name': name,
        'order': order,
        'categories': categories,
      };
      print('Request Body: ${jsonEncode(requestBody)}');

      // API Call
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        if (response.statusCode == 201) {
          //Get.snackbar("Success", "Attribute created successfully");
          print('Attribute Created Successfully: $data');

          Get.snackbar(
            'Success',
            'Attribute value created successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
          );

          final AttributesController attributesController =
              Get.put(AttributesController());

          attributesController.fetchAttributes();

          Get.to(AttributeListPage(),
              transition: Transition.rightToLeftWithFade);
        } else {
          errorMessage.value = data['message'] ?? 'Failed to create attribute';
        }
      } else {
        var errorData = json.decode(response.body);
        errorMessage.value =
            errorData['message'] ?? 'Failed to create attribute';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      print('Error: $e');
    } finally {
      isLoading(false);
      print('API Call Ended');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    orderController.dispose();
    super.dispose();
  }
}
