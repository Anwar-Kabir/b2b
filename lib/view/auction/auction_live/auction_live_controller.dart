import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'auction_live_model.dart';




class AuctionController extends GetxController {
  var liveAuctions = <Auction>[].obs; // Observable list of Auction objects
  var isLoading = false.obs; // Observable for loading state

  @override
  void onInit() {
    super.onInit();
    fetchLiveAuctions(); // Fetch live auctions when controller is initialized
  }

  Future<void> fetchLiveAuctions() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    // const url = 'https://e-commerce.isotopeit.com/api/auctions/live';
     const url = AppURL.auctionLive;

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Auction> auctions = (data['data']['data'] as List)
            .map((json) => Auction.fromJson(json))
            .toList();
        liveAuctions.assignAll(auctions);
      } else {
        debugPrint(
            'Failed to load live auctions. Status code: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to load live auctions');
      }
    } catch (e) {
      debugPrint('Error fetching live auctions: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
