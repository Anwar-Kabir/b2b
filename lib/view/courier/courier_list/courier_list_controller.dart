import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/courier/courier_list/courier_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourierController extends GetxController {
  var isLoading = false.obs;
  var couriers = <CourierData>[].obs;

  Future<void> fetchCouriers() async {
    isLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      final response = await http.get(
        Uri.parse(AppURL.courierList),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = CourierListResponse.fromJson(jsonDecode(response.body));
        if (data.success) {
          couriers.value = data.data;
           
        } else {
          Get.snackbar('Error', data.message);
        }
      } else {
        //Get.snackbar( 'Error', 'Failed to load data. Status: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      //Get.snackbar('Error', 'Failed to fetch data: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchCouriers();
    super.onInit();
  }
}
