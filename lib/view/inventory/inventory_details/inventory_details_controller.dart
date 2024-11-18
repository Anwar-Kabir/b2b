// inventory_detail_controller.dart

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/utils/url.dart';
import 'dart:convert';
import 'package:isotopeit_b2b/view/inventory/inventory_details/inventory_product_details_model.dart';

class InventoryDetailController extends GetxController {
  var inventoryDetail = Rxn<InventoryDetailModel>();
  var isLoading = false.obs;
  var hasError = false.obs;

  final TokenService _tokenService = TokenService();

  Future<void> fetchInventoryDetail(int id) async {
    isLoading.value = true;
    hasError.value = false;
    // final url = 'https://e-commerce.isotopeit.com/api/inventory/$id';
    final url = '${AppURL.baseURL}api/inventory/$id';
    
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${_tokenService.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        inventoryDetail.value = InventoryDetailModel.fromJson(data);
      } else {
        hasError.value = true;
      }
    } catch (e) {
      hasError.value = true;
      print("Error fetching inventory details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Modified delete function to return boolean on success/failure
  Future<bool> deleteInventoryItem(int inventoryId) async {
    try {
      isLoading(true);
      final response = await http.delete(
        // Uri.parse('https://e-commerce.isotopeit.com/api/inventory/$inventoryId'),
        Uri.parse("${AppURL.baseURL}api/inventory/$inventoryId"),

        headers: {
          'Authorization': 'Bearer ${_tokenService.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var deleteResponse =
            InventoryDeleteResponse.fromJson(json.decode(response.body));
        //et.snackbar('Success', deleteResponse.message);
        return true; // Indicate success
      } else {
        Get.snackbar('Error', 'Failed to delete inventory item');
        return false; // Indicate failure
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      return false; // Indicate failure
    } finally {
      isLoading(false);
    }
  }
}
