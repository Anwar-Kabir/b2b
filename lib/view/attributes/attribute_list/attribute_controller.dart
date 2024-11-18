import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'attribute_model.dart';

class AttributesController extends GetxController {
  var isLoading = false.obs;
  var attributes = <Attribute>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttributes();
  }

  Future<void> fetchAttributes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    // const url = 'https://e-commerce.isotopeit.com/api/attribute';
    const url = AppURL.attributeList;


    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var attributeList = data['data']['attributes'] as List;

        attributes.value = attributeList
            .map((attribute) => Attribute.fromJson(attribute))
            .toList();
      } else {
        Get.snackbar("Error", "Failed to load attributes");
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading(false);
    }
  }
}
