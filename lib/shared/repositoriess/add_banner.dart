import 'dart:convert';

import '../models/banner.dart';
import '../services/api_services.dart';

class AddBanner {
  final _apiService = ApiService();

  Future<Banner?> fetchAddBanner({
    required String token,
    required String description,
    required String link,
    required String title,
    required String linkLabel,
    required String color,
    required String images,
    required int columns,
    required int order,
    required int effect,
  }) async {
    final response = await _apiService.responseBanner(
      token: token,
      description: description,
      link: link,
      title: title,
      linkLabel: linkLabel,
      color: color,
      images: images,
      columns: columns,
      order: order,
      effect: effect,
    );
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final addBanner = Banner.fromJson(json);
      return addBanner;
    }
    return null;
  }
}
