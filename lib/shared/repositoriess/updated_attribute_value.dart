import 'dart:convert';

import '../models/update_attribute_value.dart';
import '../services/api_services.dart';

class UpdateAttributeValueRepo {
  final _apiService = ApiService();

  Future<UpdateAttributeValue?> fetchUpdateAttributeValue({
    required int id,
    required int attributeId,
    required String value,
    required double order,
    required String color,
    required String token,
  }) async {
    final response = await _apiService.responseUpdateAttributeValues(
      id: id,
      attributeId: attributeId,
      value: value,
      order: order,
      color: color,
      token: token,
    );
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final updateAttributeValue = UpdateAttributeValue.fromJson(json);
      return updateAttributeValue;
    }
    return null;
  }
}
