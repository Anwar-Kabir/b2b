import 'dart:convert';

import '../models/single_attribute.dart';
import '../services/api_services.dart';

class UpdateAttributeRepo {
  final _apiService = ApiService();

  Future<SingleAttribute?> fetchUpdateAttribute({
    required int id,
    required String name,
    required double order,
    required List<double> categories,
    required String token,
  }) async {
    final response = await _apiService.responseUpdateAttribute(
      id: id,
      name: name,
      order: order,
      categories: categories,
      token: token,
    );
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final attribute = SingleAttribute.fromJson(json);
      return attribute;
    }
    return null;
  }
}
