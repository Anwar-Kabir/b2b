import 'dart:convert';

import '../models/order_details.dart';
import '../services/api_services.dart';

class OrderDetailsRepo {
  final _apiService = ApiService();

  Future<OrderDetails?> fetchOrderDetails({
    required int orderId,
    required String token,
  }) async {
    final response = await _apiService.requestOrderDetails(
      orderId: orderId,
      token: token,
    );
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final orderDetails = OrderDetails.fromJson(json);
      return orderDetails;
    }
    return null;
  }
}
