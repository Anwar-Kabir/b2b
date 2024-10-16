import 'dart:convert';

import '../models/login.dart';
import '../services/api_services.dart';

class LoginRepo {
  final _apiService = ApiService();

  Future<Login?> fetchLogin({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.responseLogin(
      email: email,
      password: password,
    );
    if (response != null) {
      final bodyStr = response.body;
      final json = jsonDecode(bodyStr) as Map<String, dynamic>;
      final login = Login.fromJson(json);
      return login;
    }
    return null;
  }
}
