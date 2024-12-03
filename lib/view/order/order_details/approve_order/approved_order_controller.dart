import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/order/order_details/approve_order/approved_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ApproveController extends GetxController {
//   final isLoading = false.obs;
//   final isApproved = false.obs;

//   Future<void> approveOrder(int orderId) async {
//     isLoading.value = true;
//     final url = Uri.parse('https://baseurl.com/api/order/$orderId/approve');

//      final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? '';

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//            'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         final approveResponse = ApproveResponse.fromJson(jsonData);

//         if (approveResponse.status == "success") {
//           isApproved.value = true;
//           Get.snackbar('Success', approveResponse.message,
//               backgroundColor: Colors.green, colorText: Colors.white);
//         } else {
//           Get.snackbar('Error', approveResponse.message,
//               backgroundColor: Colors.red, colorText: Colors.white);
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to approve order',
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Something went wrong: $e',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

class ApproveController extends GetxController {
  final isLoading = false.obs;
  final isApproved = false.obs;

  Future<void> approveOrder(int orderId) async {
    isLoading.value = true;
    final url = Uri.parse('${AppURL.baseURL}api/order/$orderId/approve');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Handle success response
        final jsonData = json.decode(response.body);
        final approveResponse = ApproveResponse.fromJson(jsonData);

        if (approveResponse.status == "success") {
          isApproved.value = true;
          Get.snackbar('Success', approveResponse.message,
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar('Error', approveResponse.message,
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        // Handle error response
        String errorMessage = 'Failed to approve order.';
        try {
          final errorData = json.decode(response.body);
          if (errorData is Map<String, dynamic> &&
              errorData.containsKey('message')) {
            errorMessage = errorData['message'];
          }
        } catch (e) {
          errorMessage = 'Unexpected error: ${response.body}';
        }

        Get.snackbar('Error', errorMessage,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // Handle network or unexpected errors
      Get.snackbar('Error', 'Something went wrong: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
