// home_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'dart:convert';
import 'package:isotopeit_b2b/view/home/model/wallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletController extends GetxController {
  var wallet = Wallet(balance: "0.00").obs;
  var isLoading = true.obs;
  var isWalletAvailable = false.obs; // Track wallet availability

  @override
  void onInit() {
    fetchWalletBalance();
    super.onInit();
  }

  Future<void> fetchWalletBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(AppURL.walletBalance),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        wallet.value = Wallet.fromJson(jsonResponse);
        isWalletAvailable.value = true; // Wallet exists
      } else {
        isWalletAvailable.value = false; // Wallet does not exist
        // Get.snackbar("Error",
        //     "Failed to load wallet balance. Status: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      print("Error fetching wallet balance: $e");
      //Get.snackbar("Error", "Failed to fetch data: $e");
    } finally {
      isLoading(false);
    }
  }
}
