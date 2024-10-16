import 'dart:convert';

import '../models/create_attribute.dart';
import '../services/api_services.dart';

class CreateAttributesRepo {
  final _apiService = ApiService();

  Future<CreateAttribute?> fetchCreateAttribute({
    required String name,
    required double order,
    required List<double> categories,
    required String token,
  }) async {
    final response = await _apiService.responseCreateAttribute(
      name: name,
      order: order,
      categories: categories,
      token: token,
    );
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final createAttribute = CreateAttribute.fromJson(json);
      return createAttribute;
    }
    return null;
  }
}
