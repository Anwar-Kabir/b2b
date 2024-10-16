import 'dart:convert';

import '../models/single_attribute.dart';
import '../services/api_services.dart';

class TagRepo {
  final _apiService = ApiService();

  Future<Category?> fetchTag({
    required String token,
  }) async {
    final response = await _apiService.requestTag(token: token);
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final categoryList = Category.fromJson(json);
      return categoryList;
    }
    return null;
  }
}
