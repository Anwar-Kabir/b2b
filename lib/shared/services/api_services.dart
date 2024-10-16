import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService {
  // eager Singleton
  ApiService._();
  static final _instance = ApiService._();
  factory ApiService() => _instance;

  //-- Configs
  String get baseUrl => 'https://e-commerce.isotopeit.com/';

  // Login - post
  Future<http.Response?> responseLogin({
    required String email,
    required String password,
  }) async {
    final body = {
      "email": email,
      "password": password,
    };
    try {
      final Uri url = Uri.parse("$baseUrl/api/suppliers-login");
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: body,
      );
      return _checkStatusCode(response);
    } catch (e, s) {
      log("ApiService: Couldn't request users!", error: e, stackTrace: s);
    }
    return null;
  }

  // Attribute List - get
  Future<http.Response?> requestAttributes({required String token}) async {
    try {
      final Uri url = Uri.parse("$baseUrl/api/attribute");
      final response = await http.get(
        url,
        headers: _getHeaders(token),
      );
      return _checkStatusCode(response);
    } catch (e, s) {
      log("ApiService: Couldn't request users!", error: e, stackTrace: s);
    }
    return null;
  }

  // Create Attribute - post
  Future<http.Response?> responseCreateAttribute({
    required String name,
    required double order,
    required List<double> categories,
    required String token,
  }) async {
    final body = {
      "name": name,
      "order": order,
      "categories": categories,
    };
    try {
      final Uri url = Uri.parse("$baseUrl/api/attribute");
      final response = await http.post(
        url,
        headers: _getHeaders(token),
        body: body,
      );
      return _checkStatusCode(response);
    } catch (e, s) {
      log("ApiService: Couldn't request users!", error: e, stackTrace: s);
    }
    return null;
  }

  // Single Attribute - get
  Future<http.Response?> requestSingleAttribute(
      {required int id, required String token}) async {
    try {
      final Uri url = Uri.parse("$baseUrl/api/attribute/$id");
      final response = await http.get(
        url,
        headers: _getHeaders(token),
      );
      return _checkStatusCode(response);
    } catch (e, s) {
      log("ApiService: Couldn't request users!", error: e, stackTrace: s);
    }
    return null;
  }

  // Category Group - get
  Future<http.Response?> requestCategoryGroup({required String token}) async {
    try {
      final Uri url = Uri.parse("$baseUrl/api/select/category-groups");
      final response = await http.get(
        url,
        headers: _getHeaders(token),
      );
      return _checkStatusCode(response);
    } catch (e, s) {
      log("ApiService: Couldn't request users!", error: e, stackTrace: s);
    }
    return null;
  }



  /// +++++++++++ ||| ++++++++++++
  /// Get basic headers.
  Map<String, String> _getHeaders([String? token]) => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

  /// Check basic headers.
  http.Response? _checkStatusCode(http.Response response) =>
      response.statusCode >= 200 && response.statusCode < 300 ? response : null;
}
