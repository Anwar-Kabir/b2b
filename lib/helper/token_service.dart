import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static final TokenService _instance = TokenService._internal();
  factory TokenService() => _instance;

  SharedPreferences? _prefs;
  String? _token;

  TokenService._internal();

  // Initialize the SharedPreferences instance
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs?.getString('token') ?? '';
  }

  // Getter for token
  String get token => _token ?? '';

  // Method to save token
  Future<void> setToken(String token) async {
    _token = token;
    await _prefs?.setString('token', token);
  }

  // Method to clear token (e.g., on logout)
  Future<void> clearToken() async {
    _token = null;
    await _prefs?.remove('token');
  }
}
