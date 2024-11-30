// controllers/category_controller.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/subsubcategory/sub_sub_category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryController {
  final String baseUrl = "${AppURL.baseURL}api/category/";

  Future<List<CategoryModel>> fetchCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ensure that we retrieve a non-null token
    final token = prefs.getString('token') ?? '';

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> categoryGroups = data['data']['categoryGroups'];
      return categoryGroups
          .map((category) => CategoryModel.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
