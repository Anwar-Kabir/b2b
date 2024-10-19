import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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

  // Fetch order details using GetX and API
  Future<void> fetchOrderDetails(int orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? ''; // Ensure token is retrieved

    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://e-commerce.isotopeit.com/api/order/$orderId/show'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        orderDetails.value = OrderModel.fromJson(jsonResponse);
      } else {
        Get.snackbar('Error', 'Failed to fetch order details');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch order details');
    } finally {
      isLoading(false);
    }
  }
}
