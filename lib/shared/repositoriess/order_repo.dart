import 'dart:convert';

import '../models/order.dart';
import '../services/api_services.dart';

class OrderRepo {
  final _apiService = ApiService();

  Future<Order?> fetchOrder({
    required String token,
  }) async {
    final response = await _apiService.requestOrders(token: token);
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final orders = Order.fromJson(json);
      return orders;
    }
    return null;
  }
}
