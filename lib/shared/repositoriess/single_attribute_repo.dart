import 'dart:convert';

import '../models/single_attribute.dart';
import '../services/api_services.dart';

class SingleAttributeRepo {
  final _apiService = ApiService();

  Future<SingleAttribute?> fetchSingleAttribute({
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
      final attribute = SingleAttribute.fromJson(json);
      return attribute;
    }
    return null;
  }
}
