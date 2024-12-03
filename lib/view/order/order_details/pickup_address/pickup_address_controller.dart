import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/view/order/order_details/pickup_address/pickup_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickupAddressController extends GetxController {
  final isLoading = false.obs;
  final List<PickupAddress> addresses = <PickupAddress>[].obs;

  Future<void> fetchPickupAddresses() async {
    isLoading.value = true;
    final url = Uri.parse('https://beta.pykari.com/api/order/picup-address');

     final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? ''; 
    
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',  
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success'] == true) {
          addresses.clear();
          for (var item in jsonData['data']) {
            addresses.add(PickupAddress.fromJson(item));
          }
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch pickup addresses',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
