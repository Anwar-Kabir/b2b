import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'dart:convert';

import 'package:isotopeit_b2b/view/order/order_details/model_order_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsController extends GetxController {
  var orderDetails = OrderModel(
          status: '',
          data: OrderData(
              id: 0,
              orderNumber: '',
              itemCount: 0,
              total: '',
              grandTotal: '',
              customerEmail: '',
              customerPhoneNumber: '',
              items: [],
              customerId: 0,
              discount: '',
              taxes: '',
              deliveryCharge: '',
              totalPaymentAmount: '',
              paymentStatus: false,
              orderStatus: false,
              buyerNote: ''))
      .obs;
  var isLoading = true.obs;

  

  Future<void> fetchOrderDetails(int orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? ''; // Ensure token is retrieved

    try {
      isLoading(true);
      final url = '${AppURL.baseURL}api/order/$orderId/show';
      print('Fetching order details from: $url');
      print('Authorization Token: $token');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('HTTP Status Code: ${response.statusCode}');
      print('HTTP Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print('Parsed Response: $jsonResponse');
        orderDetails.value = OrderModel.fromJson(jsonResponse);
      } else {
        Get.snackbar('Error', 'Failed to fetch order details');
        print(
            'Error: Failed to fetch order details. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch order details');
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }
}










// Fetch order details using GetX and API
  // Future<void> fetchOrderDetails(int orderId) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token') ?? ''; // Ensure token is retrieved

  //   try {
  //     isLoading(true);
  //     final response = await http.get(
  //       // Uri.parse('https://e-commerce.isotopeit.com/api/order/$orderId/show'),
  //       Uri.parse('${AppURL.baseURL}api/order/$orderId/show'),

  //       headers: {
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.decode(response.body);
  //       orderDetails.value = OrderModel.fromJson(jsonResponse);
  //     } else {
  //       Get.snackbar('Error', 'Failed to fetch order details');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch order details');
  //   } finally {
  //     isLoading(false);
  //   }
  // }




 