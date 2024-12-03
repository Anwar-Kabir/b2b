import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'uom_model.dart'; // Import the UomModel file

class UomController extends GetxController {
  var isLoading = true.obs;
  var uomList = <UomModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUomList();
  }

  Future<void> fetchUomList() async {
    const String url = "${AppURL.baseURL}api/uom/";
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';


    try {
      isLoading(true);
      final response = await http.get(Uri.parse(url),
       headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }, 
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final uomResponse = UomResponse.fromJson(jsonResponse);
        if (uomResponse.status) {
          uomList.assignAll(uomResponse.uomList);
        }
      } else {
        Get.snackbar("Error", "Failed to fetch data");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
