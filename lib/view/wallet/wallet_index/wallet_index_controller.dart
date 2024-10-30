import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'dart:convert';

import 'package:isotopeit_b2b/view/wallet/wallet_index/wallet_index_model.dart';

class WalletIndexController extends GetxController {
  var requests = <WalletWithdrawRequest>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchWithdrawRequests();
    super.onInit();
  }

  final TokenService _tokenService = TokenService();

  Future<void> fetchWithdrawRequests() async {
    isLoading(true);
    try {
      final response = await http.get(Uri.parse(
        
          "https://e-commerce.isotopeit.com/api/wallet-withdraw-requests-index"),
          headers: {
          'Authorization': 'Bearer ${_tokenService.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
          );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        requests.value =
            data.map((json) => WalletWithdrawRequest.fromJson(json)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch data");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to connect to the server");
    } finally {
      isLoading(false);
    }
  }
}
