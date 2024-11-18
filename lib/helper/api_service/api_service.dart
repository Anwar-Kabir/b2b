import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.example.com";

  // Common headers
  static Map<String, String> _headers({String? token}) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // GET method
  static Future<dynamic> get(String endpoint, {String? token}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers(token: token),
      );
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  // POST method
  static Future<dynamic> post(String endpoint,
      {String? token, Map<String, dynamic>? body}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers(token: token),
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  // DELETE method
  static Future<dynamic> delete(String endpoint, {String? token}) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers(token: token),
      );
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  // Handle HTTP response
  static dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 401:
        throw Exception("Unauthorized. Please login again.");
      case 403:
        throw Exception("Access denied.");
      case 404:
        throw Exception("Resource not found.");
      case 500:
        throw Exception("Server error. Please try again later.");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  // Handle errors
  static void _handleError(dynamic error) {
    String errorMessage = "An error occurred. Please try again.";

    if (error is http.ClientException) {
      errorMessage = "No Internet Connection.";
    } else if (error is Exception) {
      errorMessage = error.toString();
    }

    // Display error using GetX Snackbar
    Get.snackbar(
      "Error",
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
    throw Exception(errorMessage);
  }
}




///get method call
///void fetchData() async {
//   try {
//     final response = await ApiService.get('products');
//     print('Data: $response');
//   } catch (e) {
//     print('Error: $e');
//   }
// }


//====post method call
// void createUser() async {
//   try {
//     final response = await ApiService.post('users',
//         body: {'name': 'John Doe', 'email': 'john@example.com'});
//     print('User Created: $response');
//   } catch (e) {
//     print('Error: $e');
//   }
// }


///======>detele method call
// void deleteUser(String userId) async {
//   try {
//     final response = await ApiService.delete('users/$userId');
//     print('User Deleted: $response');
//   } catch (e) {
//     print('Error: $e');
//   }
// }


///=====>get with token
///void createUser() async {
//   try {
//     // Retrieve the token
//     final token = await getToken();

//     if (token == null) {
//       throw Exception("No token found. Please login again.");
//     }

//     // Make the API call with the token
//     final response = await ApiService.post(
//       'users',
//       body: {'name': 'John Doe', 'email': 'john@example.com'},
//       token: token, // Pass the token here
//     );

//     print('User Created: $response');
//   } catch (e) {
//     print('Error: $e');
//   }
// }


// ====>token with post
// void createUser() async {
//   try {
//     // Retrieve the token
//     final token = await getToken();

//     if (token == null) {
//       throw Exception("No token found. Please login again.");
//     }

//     // Make the API call with the token
//     final response = await ApiService.post(
//       'users',
//       body: {'name': 'John Doe', 'email': 'john@example.com'},
//       token: token, // Pass the token here
//     );

//     print('User Created: $response');
//   } catch (e) {
//     print('Error: $e');
//   }
// }


// static Future<dynamic> post(String endpoint,
//     {String? token, Map<String, dynamic>? body}) async {
//   try {
//     final response = await http.post(
//       Uri.parse('$baseUrl/$endpoint'),
//       headers: _headers(token: token), // Use token in headers
//       body: jsonEncode(body),
//     );
//     return _handleResponse(response);
//   } catch (e) {
//     _handleError(e);
//   }
// }


