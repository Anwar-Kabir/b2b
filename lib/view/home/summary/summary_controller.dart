import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SummaryController extends GetxController {
  var totalOrders = 0.obs;
  var totalInventory = 0.obs;
  var totalProducts = 0.obs;
  var totalCouriers = 0.obs;

  @override
  void onInit() {
    fetchSummaryData();
    super.onInit();
  }

  Future<void> fetchSummaryData() async {
    const baseUrl = "${AppURL.baseURL}";

    Future<int> _fetchData(String endpoint) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData['total_orders'] ??
            jsonData['total_inventory'] ??
            jsonData['total_product'] ??
            jsonData['total_courier'];
      } else {
        throw Exception('Failed to fetch $endpoint');
      }
    }

    try {
      totalOrders.value = await _fetchData('api/all-orders');
      totalInventory.value = await _fetchData('api/all-inventory');
      totalProducts.value = await _fetchData('api/all-product');
      totalCouriers.value = await _fetchData('api/all-courier');

      // Print the values to the console
      printSummaryValues();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void printSummaryValues() {
    print('Total Orders: ${totalOrders.value}');
    print('Total Inventory: ${totalInventory.value}');
    print('Total Products: ${totalProducts.value}');
    print('Total Couriers: ${totalCouriers.value}');
  }
}
