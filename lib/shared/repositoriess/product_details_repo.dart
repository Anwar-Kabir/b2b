import 'dart:convert';

import '../models/product_details.dart';
import '../services/api_services.dart';

class ProductDetailsRepo {
  final _apiService = ApiService();

  Future<ProductDetails?> fetchTag({
    required int productId,
    required String token,
  }) async {
    final response = await _apiService.requestProductDetails(
      productId: productId,
      token: token,
    );
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final productDetails = ProductDetails.fromJson(json);
      return productDetails;
    }
    return null;
  }
}
