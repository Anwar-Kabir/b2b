import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/wallet/wallet_index/wallet.dart';
import 'package:isotopeit_b2b/view/wallet/wallet_index/wallet_index_controller.dart';

import 'package:isotopeit_b2b/view/wallet/withdraw_request/request_money_model.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For using the Snackbar

class WalletWithdrawController extends GetxController {
  var isLoading = false.obs;

  Future<void> requestWithdraw(int amount) async {
    isLoading(true);

    // const url = 'https://e-commerce.isotopeit.com/api/wallet-withdraw-requests';
    const url = '${AppURL.baseURL}api/wallet-withdraw-requests';

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

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        var withdrawResponse = WalletWithdrawResponse.fromJson(jsonResponse);

        final WalletIndexController controller =
            Get.put(WalletIndexController());

        controller.fetchWithdrawRequests();

        Get.offAll(Wallet(), transition: Transition.leftToRightWithFade);

        Get.snackbar("Success", 'Successfully Create Withdraw Request',
            backgroundColor: Colors.green, colorText: Colors.white);
        print(response.body);
      } else {
        Get.snackbar(
            "Error", "Failed to create withdraw request. ${response.body}");
        print(response.body);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }
}
