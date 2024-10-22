import 'package:get/get.dart';
import 'package:isotopeit_b2b/view/banner/model_banner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 

class BannerController extends GetxController {
  var isLoading = true.obs;
  var banners = <BannerItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    isLoading(true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var response = await http.get(
        Uri.parse('https://e-commerce.isotopeit.com/api/banners'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        BannerResponse bannerResponse = BannerResponse.fromJson(data);
        banners.value = bannerResponse.data.banners;
      } else {
        Get.snackbar('Error', 'Failed to load banners');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading(false);
    }
  }
}
