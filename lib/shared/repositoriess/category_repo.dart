import 'dart:convert';

import '../models/category_group.dart';
import '../services/api_services.dart';

class CategoryGroupRepo {
  final _apiService = ApiService();

  Future<CategoryGroup?> fetchCategoryGroup({
    required String token,
  }) async {
    final response = await _apiService.requestCategoryGroup(
      token: token,
    );
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final categoryGroup = CategoryGroup.fromJson(json);
      return categoryGroup;
    }
    return null;
  }
}
