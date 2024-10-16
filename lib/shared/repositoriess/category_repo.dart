import 'dart:convert';

import '../models/attribute.dart';
import '../services/api_services.dart';

class CategoryGroupRepo {
  final _apiService = ApiService();

  Future<AttributeList?> fetchCategoryGroup({
    required String token,
  }) async {
    final response = await _apiService.requestCategoryGroup(
      token: token,
    );
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final attributeList = AttributeList.fromJson(json);
      return attributeList;
    }
    return null;
  }
}
