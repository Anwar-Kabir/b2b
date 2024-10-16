import 'dart:convert';

import '../models/tag.dart';
import '../services/api_services.dart';

class CategoryListRepo {
  final _apiService = ApiService();

  Future<Tag?> fetchCategoryList({
    required String token,
  }) async {
    final response = await _apiService.requestCategoryList(token: token);
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final tag = Tag.fromJson(json);
      return tag;
    }
    return null;
  }
}
