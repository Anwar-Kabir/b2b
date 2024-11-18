import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:http_parser/http_parser.dart';
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/banner/banner/banner.dart';
import 'package:isotopeit_b2b/view/banner/banner/controller_banner.dart';

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
    //final url = Uri.parse('https://e-commerce.isotopeit.com/api/banners'); // Ensure this URL is correct
    final url = Uri.parse(AppURL.bannerCreate);
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
        // Get.snackbar("Success", message);
        Get.snackbar(
          "Success",
          message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );
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

 
   ///update ==============>>

  Future<bool> updateBanner(int id) async {
    final url = Uri.parse('${AppURL.bannerUpdate}$id');
    final headers = {
      'Authorization': 'Bearer ${_tokenService.token}',
      'Accept': 'application/json',
    };

    print('API URL: $url');
    print('Authorization Token: ${_tokenService.token}');

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    // Add '_method' field to specify PUT method
    request.fields['_method'] = 'PUT';

    // Add text fields
    request.fields['title'] = titleController.text;
    request.fields['description'] = descriptionController.text;
    request.fields['link'] = linkController.text;
    request.fields['link_label'] = linkLabelController.text;
    request.fields['bg_color'] = bgColorController.text;
    request.fields['columns'] = columnsController.text;
    request.fields['order'] = orderController.text;
    request.fields['effect'] =
        effectController.text.toLowerCase() == 'true' ? '1' : '0';

    // Ensure that image file is selected and exists
    if (featureImagePath.value != null && featureImagePath.value.isNotEmpty) {
      print('Feature Image Path: ${featureImagePath.value}');

      // Check if the file exists
      File featureImageFile = File(featureImagePath.value);
      if (await featureImageFile.exists()) {
        String contentType =
            'image/jpeg'; // Default content type for JPEG images

        // Check file extension and set content type accordingly
        if (featureImagePath.value.endsWith('.png')) {
          contentType = 'image/png';
        } else if (featureImagePath.value.endsWith('.jpg')) {
          contentType = 'image/jpeg';
        }

        // Add the image to the multipart request
        request.files.add(await http.MultipartFile.fromPath(
          'images[feature]', // Ensure this matches API expectations
          featureImagePath.value,
          contentType: MediaType.parse(contentType),
        ));
      } else {
        print('Image file not found at path: ${featureImagePath.value}');
        Get.snackbar(
          "Error",
          "The selected image file was not found.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } else {
      print('No feature image selected');
      Get.snackbar(
        "Error",
        "Please select a banner image.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Show circular progress indicator
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible:
          false, // Disable closing the dialog by tapping outside
    );

    try {
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      // Print the response data for debugging
      print('Response Data: ${responseData.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(responseData.body);

        // Show success message
        Get.snackbar(
          "Success",
          data['message'] ?? "Banner updated successfully.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Close the circular progress indicator
        Get.back(); // Close the dialog after the API call is finished

        // Refresh the banner list by calling fetchBanners on the controller
        final BannerController bannerController = Get.find<BannerController>();
        await bannerController.fetchBanners();

        // Navigate to the banner list page
        Get.to(BannerManager(), transition: Transition.rightToLeftWithFade);

        return true;
      } else {
        final errorData = jsonDecode(responseData.body);
        Get.snackbar(
          "Error",
          errorData['message'] ?? "Failed to update banner.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return false;
      }
    } catch (error) {
      print('Error: $error');
      Get.snackbar(
        "Error",
        "An error occurred while updating the banner. $error",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      // Close the circular progress indicator
      Get.back(); // Close the dialog after the API call is finished
    }
  }



}
