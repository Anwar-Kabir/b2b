import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/attributes/add_attribute_value/model/add_attribute_value_create_model.dart';
import 'package:isotopeit_b2b/view/attributes/attribute_list/attribute.dart';
import 'package:isotopeit_b2b/view/attributes/attribute_list/attribute_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAttributeValueCreateController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> createAttributeValue(
      AttributeValueCreateModel attributeValue) async {
    isLoading(true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      const url = '${AppURL.baseURL}api/attribute-values';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(attributeValue.toJson()),
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Attribute value created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );
         
         final AttributesController attributesController =
            Get.put(AttributesController());

         attributesController.fetchAttributes();

        Get.to(AttributeListPage(), transition: Transition.rightToLeftWithFade);
        print('Response: ${response.body}');
      } else {
        errorMessage.value = 'Failed to create attribute value';
        print('Error: ${response.body}');
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }
}
