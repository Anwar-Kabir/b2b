import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:http_parser/http_parser.dart';

class AddBannerController extends GetxController {
  // Controllers for each field
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var linkController = TextEditingController();
  var linkLabelController = TextEditingController();
  var bgColorController = TextEditingController();
  var columnsController = TextEditingController();
  var orderController = TextEditingController();
  var effectController = TextEditingController();
  var featureImagePath = ''.obs; // Observable for image[feature] path

  final TokenService _tokenService = TokenService();


  Future<bool> createBanner() async {
    final url = Uri.parse(
        'https://e-commerce.isotopeit.com/api/banners'); // Ensure this URL is correct
    final headers = {
      'Authorization': 'Bearer ${_tokenService.token}',
      'Accept': 'application/json',
    };

    // Create a MultipartRequest
    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    // Add text fields
    request.fields['title'] = titleController.text;
    request.fields['description'] = descriptionController.text;
    request.fields['link'] = linkController.text;
    request.fields['link_label'] = linkLabelController.text;
    request.fields['bg_color'] = bgColorController.text;
    request.fields['columns'] = columnsController.text;
    request.fields['order'] = orderController.text;
    request.fields['effect'] = effectController.text.toLowerCase() == 'true'
        ? '1'
        : '0'; // Use '1' or '0' for boolean
    //request.fields['shop_id'] = '2'; // Set shop_id as needed

    // Add image file
    if (featureImagePath.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'images[feature]',
        featureImagePath.value,
        contentType: MediaType('image',
            'jpeg'), // Change if necessary based on the actual file type
      ));
    }

    try {
      final response = await request.send();

      // Get the response body
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(responseData.body);
        final message = data['message'] ??
            'Banner created successfully without a message field.';

        print("Full response data: $data");
        print("Banner created successfully: $message");
        Get.snackbar("Success", message);
        return true;
      } else {
        print("Failed to create banner: ${responseData.body}");
        Get.snackbar("Error", "Failed to create banner. ${responseData.body}");
        return false;
      }
    } catch (error) {
      print("Error occurred: $error");
      Get.snackbar("Error", "An error occurred while creating the banner.");
      return false;
    }
  }

  // Method to set feature image path
  void setFeatureImagePath(String path) {
    featureImagePath.value = path;
  }
}
