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

  //Update Attribute - put
  Future<http.Response?> responseUpdateAttribute({
    required int id,
    required String name,
    required double order,
    required List<double> categories,
    required String token,
  }) async {
    final body = {
      "id": id,
      "name": name,
      "order": order,
      "categories": categories,
    };
    try {
      final Uri url = Uri.parse("$baseUrl/api/attribute/$id");
      final response = await http.put(
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

  //Update Attribute Value - put
  Future<http.Response?> responseUpdateAttributeValues({
    required int id,
    required int attributeId,
    required String value,
    required double order,
    required String color,
    required String token,
  }) async {
    final body = {
      "id": id,
      "attribute_id": attributeId,
      "value": value,
      "order": order,
      "color": color,
    };
    try {
      final Uri url = Uri.parse("$baseUrl/api/attribute/$attributeId");
      final response = await http.put(
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

  // Category List - get
  Future<http.Response?> requestCategoryList({required String token}) async {
    try {
      final Uri url = Uri.parse("$baseUrl/api/category/");
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

  // Tag - get
  Future<http.Response?> requestTag({required String token}) async {
    try {
      final Uri url = Uri.parse("$baseUrl/api/tag");
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

  // ProductList - get
  Future<http.Response?> requestProductList({required String token}) async {
    try {
      final Uri url = Uri.parse("$baseUrl/api/product");
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

  // Product Details - get
  Future<http.Response?> requestProductDetails({
    required int productId,
    required String token,
  }) async {
    try {
      final Uri url = Uri.parse("$baseUrl/api/product/$productId/show/");
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

  // Order list Details - get
  Future<http.Response?> requestOrders({required String token}) async {
    try {
      final Uri url = Uri.parse("$baseUrl/api/order/");
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

  // Order Details - get
  Future<http.Response?> requestOrderDetails(
      {required int orderId, required String token}) async {
    try {
      final Uri url = Uri.parse("$baseUrl/api/order/$orderId/show");
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

  // Banner list - get
  Future<http.Response?> requestBanners({required String token}) async {
    try {
      final Uri url = Uri.parse("$baseUrl/api/banners/");
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

  // Banner list - get
  Future<http.Response?> responseBanner({
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
    final body = {
      "description": description,
      "link": link,
      "title": title,
      "link_label": linkLabel,
      "bg_color": color,
      "columns": columns,
      "order": order,
      "effect": effect,
      "images": images,
    };
    try {
      final Uri url = Uri.parse("$baseUrl/api/banners/");
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
