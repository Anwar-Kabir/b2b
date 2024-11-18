// courier_detail_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/courier/courier_list_details/courier_list_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
 

class CourierDetailController extends GetxController {
  var isLoading = false.obs;
  var courierData = Rxn<CourierData>();

  Future<void> fetchCourierDetails(int id) async {
    isLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      final response = await http.get(
          Uri.parse('${AppURL.baseURL}courier-show/$id'),
          headers: {
          'Authorization': 'Bearer $token',  
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
          );

      if (response.statusCode == 200) {
        final data = CourierDetailResponse.fromJson(jsonDecode(response.body));
        courierData.value = data.courier;
      } else {
        Get.snackbar('Error', 'Failed to load data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchCourierDetails(1); // Example id, should be dynamically passed
    super.onInit();
  }
}
