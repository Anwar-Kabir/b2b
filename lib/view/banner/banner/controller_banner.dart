import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/banner/banner/model_banner.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BannerController extends GetxController {
  var banners = <BannerData>[].obs;
  var isLoading = true.obs;

  final bannerController = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  // Fetch banners from API
  Future<void> fetchBanners() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ensure that we retrieve a non-null token
    final token = prefs.getString('token') ?? '';

    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(AppURL.bannersList),

        headers: {
          'Authorization': 'Bearer $token', // Token authorization
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ApiResponse apiResponse = ApiResponse.fromJson(jsonData);
        banners.value = apiResponse.data;
      } else {
        Get.snackbar('Error', 'Failed to fetch banners',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', ' $e Failed to fetch banners',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // Delete banner from API
  Future<void> deleteBanner(int id) async {

     final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token') ?? '';

    try {
      final response = await http.delete(
        Uri.parse('${AppURL.bannerDelete}$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Remove the banner from the local list
        banners.removeWhere((banner) => banner.id == id);

        Get.snackbar(
          "Success",
          'Banner deleted successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar('Error', 'Failed to delete banner',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
          colorText: Colors.white,

          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
            );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete banner',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        colorText: Colors.white,

        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
          );
    }
  }
}














 