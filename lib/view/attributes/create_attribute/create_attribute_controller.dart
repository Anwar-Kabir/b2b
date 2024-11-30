import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/url.dart';
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

  Future<void> createAttribute(List<String> categories) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    // const url = 'https://e-commerce.isotopeit.com/api/attribute';
    const url = '${AppURL.baseURL}api/attribute';


    try {
      isLoading(true);
      
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': nameController.text,
          'order': int.tryParse(orderController.text),
          'categories': categories,
        }),
      );

      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          Get.snackbar("Success", "Attribute created successfully");
          print(data);
          print(response.body);
        } else {
          errorMessage.value = 'Failed to create attribute';
        }
      } else {
        errorMessage.value = 'Failed to create attribute';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading(false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    orderController.dispose();
    super.dispose();
  }
}
