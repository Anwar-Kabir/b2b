import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/view/category&tag/tag/model_tag.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TagController extends GetxController {
  var isLoading = false.obs;
  var tags = <Tag>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTags(); // Fetch the tags when the controller is initialized
  }

  // Fetch tags from the API
  Future<void> fetchTags() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    const url = 'https://e-commerce.isotopeit.com/api/tag';

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
        final jsonResponse = json.decode(response.body);
        final tagResponse = TagResponse.fromJson(jsonResponse);
        tags.value = tagResponse.tags; // Store the tags in the observable list
      } else {
        errorMessage('Failed to load tags');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  
}
