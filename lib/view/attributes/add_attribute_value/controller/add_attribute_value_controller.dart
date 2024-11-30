import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/attributes/add_attribute_value/model/add_attribute_value_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttributeController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var attributes = <AttributeValueModel>[].obs;

  // Fetch attributes from the API
  Future<void> fetchAttributes() async {
    isLoading(true);

     final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    
    try {
      final response = await http.get(Uri.parse('${AppURL.baseURL}api/attribute/'),
       headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          attributes.value = List<AttributeValueModel>.from(
              data['data']['attributes'].map((x) => AttributeValueModel.fromJson(x)));
        } else {
          errorMessage.value = 'Failed to load attributes';
        }
      } else {
        errorMessage.value = 'Failed to load attributes';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading(false);
    }
  }
}



