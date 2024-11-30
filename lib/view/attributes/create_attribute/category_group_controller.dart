import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
 

// class CategoryGroupController extends GetxController {
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//   var categories = <String>[].obs; // List to store category names

//   Future<void> fetchCategories() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? '';

//     const url = '${AppURL.baseURL}api/category/';

//     try {
//       isLoading(true);

//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         var data = json.decode(response.body) as Map<String, dynamic>;

//         // Clear existing categories
//         categories.clear();

//         // Extract category names from the API response
//         var categoryGroups = data['data']['categoryGroups'] as List;
//         for (var categoryGroup in categoryGroups) {
//           categories.add(
            
//             categoryGroup['name']);
//         }
//       } else {
//         errorMessage.value = 'Failed to load categories';
//       }
//     } catch (e) {
//       errorMessage.value = 'An error occurred: $e';
//     } finally {
//       isLoading(false);
//     }
//   }
// }




class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});
}

class CategoryGroupController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var categories = <Category>[].obs; // Store categories as objects

  Future<void> fetchCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    const url = '${AppURL.baseURL}api/category/';

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
        var data = json.decode(response.body) as Map<String, dynamic>;
        categories.clear(); // Clear existing categories

        var categoryGroups = data['data']['categoryGroups'] as List;
        for (var categoryGroup in categoryGroups) {
          categories.add(Category(
            id: categoryGroup['id'],
            name: categoryGroup['name'],
          ));
        }
      } else {
        errorMessage.value = 'Failed to load categories';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading(false);
    }
  }
}
