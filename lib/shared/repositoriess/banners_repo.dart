import 'dart:convert';

import '../models/banner.dart';
import '../services/api_services.dart';

class BannersRepo {
  final _apiService = ApiService();

  Future<Banner?> fetchBanner({
    required String token,
  }) async {
    final response = await _apiService.requestBanners(token: token);
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final banners = Banner.fromJson(json);
      return banners;
    }
    return null;
  }
}
