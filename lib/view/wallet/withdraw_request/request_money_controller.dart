import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/view/wallet/withdraw_request/request_money_model.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For using the Snackbar

class WalletWithdrawController extends GetxController {
  var isLoading = false.obs;

  Future<void> requestWithdraw(int amount) async {
    isLoading(true);

    const url = 'https://e-commerce.isotopeit.com/api/wallet-withdraw-requests';

     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ensure that we retrieve a non-null token
    final token = prefs.getString('token') ?? '';
    
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
           'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'amount': amount.toString(), // Send the amount as string
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var withdrawResponse = WalletWithdrawResponse.fromJson(jsonResponse);

        Get.snackbar("Success", withdrawResponse.message);
      } else {
        Get.snackbar("Error", "Failed to create withdraw request.");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }
}
