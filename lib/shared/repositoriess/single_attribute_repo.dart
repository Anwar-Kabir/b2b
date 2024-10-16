import 'dart:convert';

import '../models/attribute.dart';
import '../services/api_services.dart';

class SingleAttributeRepo {
  final _apiService = ApiService();

  Future<AttributeList?> fetchSingleAttribute({
    required int id,
    required String token,
  }) async {
    final response = await _apiService.requestSingleAttribute(
      id: id,
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
