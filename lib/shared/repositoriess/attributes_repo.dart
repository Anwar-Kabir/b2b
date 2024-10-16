import 'dart:convert';

import '../models/attribute.dart';
import '../services/api_services.dart';

class AttributesRepo {
  final _apiService = ApiService();

  Future<AttributeList?> fetchAttributes({
    required String token,
  }) async {
    final response = await _apiService.requestAttributes(token: token);
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final attributeList = AttributeList.fromJson(json);
      return attributeList;
    }
    return null;
  }
}
