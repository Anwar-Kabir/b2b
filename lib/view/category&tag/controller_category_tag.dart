import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:isotopeit_b2b/view/category&tag/model_category.dart';
import 'package:isotopeit_b2b/view/category&tag/tag/model_tag.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CategoryController extends GetxController {
  var categories = <Category>[].obs; // List of categories
  var isLoading = true.obs; // Loading state
  var errorMessage = ''.obs;

  
  

  @override
  void onInit() {
    fetchCategories();
   
    super.onInit();
  }

  
  ///category ======<<<<<
  void fetchCategories() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ensure that we retrieve a non-null token
    final token = prefs.getString('token') ?? ''; 
    
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://e-commerce.isotopeit.com/api/category/'),
        headers: {
          'Authorization': 'Bearer $token',  
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data']['categoryGroups'];
        categories.value =
            List<Category>.from(data.map((item) => Category.fromJson(item)));
      } else {
        errorMessage('Failed to load categories');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

   
}