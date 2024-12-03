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
  RxString   commission                 = ''.obs;
  RxString   uom                        = ''.obs;
  RxString   moq                        = ''.obs;
  Map<String, dynamic>?    selectedAttr = {};

  @override
  void onInit() {
    super.onInit();
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
        final attributeResponse = AttributeResponse.fromJson(data);

        attributes.value = attributeResponse.formattedAttributes;
        uom.value = "${data['uom']}";
        moq.value = "${data['moq']}";
        commission.value =
            data['commission'] > 0 ? "${data['commission']}" : '';

        if (data['commission'] < 1) {
          Get.snackbar('Error', 'Commissions need to be set on the product.',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch attributes', backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
