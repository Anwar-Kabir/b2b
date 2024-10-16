import 'dart:convert';

import '../models/product.dart';
import '../services/api_services.dart';

class ProductListRepo {
  final _apiService = ApiService();

  Future<Product?> fetchProductList({
    required String token,
  }) async {
    final response = await _apiService.requestProductList(
      token: token,
    );
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final products = Product.fromJson(json);
      return products;
    }
    return null;
  }
}
