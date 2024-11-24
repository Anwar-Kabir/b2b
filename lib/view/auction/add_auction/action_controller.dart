 import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/view/auction/add_auction/add_auction_model.dart';
import 'package:http/http.dart' as http;

final TokenService _tokenService = TokenService();

class AddAuctionController extends GetxController {
  final isCertified = false.obs;
  final startDateTimeController = TextEditingController();
  final endDateTimeController = TextEditingController();
  final availableDateTimeController = TextEditingController();

  final List<TextEditingController> keyFeatureControllers = [
    TextEditingController()
  ];

  final availableTags =
      ["Stock Limited", "Top Trending", "Best Seller", "New Arrival"].obs;
  final selectedTags = <String>[].obs;

  final imagePicker = ImagePicker();
  final imageFiles = <XFile>[].obs;

  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;
  DateTime? selectedAvailableDateTime;

  Future<void> pickImage(ImageSource source, {bool multiple = false}) async {
    if (multiple) {
      final pickedFiles = await imagePicker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        imageFiles.addAll(pickedFiles.take(5 - imageFiles.length));
      }
    } else {
      final pickedFile = await imagePicker.pickImage(source: source);
      if (pickedFile != null && imageFiles.length < 5) {
        imageFiles.add(pickedFile);
      }
    }
  }

  void removeImage(int index) {
    imageFiles.removeAt(index);
  }

  void addTag(String tag) {
    if (!selectedTags.contains(tag)) {
      selectedTags.add(tag);
    }
  }

  void removeTag(String tag) {
    selectedTags.remove(tag);
  }

  void addKeyFeature() {
    keyFeatureControllers.add(TextEditingController());
  }

  void removeKeyFeature(int index) {
    if (keyFeatureControllers.length > 1) {
      keyFeatureControllers[index].dispose();
      keyFeatureControllers.removeAt(index);
    }
  }

  Future<DateTime?> pickDateTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        return DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
    return null;
  }

  @override
  void dispose() {
    startDateTimeController.dispose();
    endDateTimeController.dispose();
    availableDateTimeController.dispose();
    for (var controller in keyFeatureControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  var isLoading = false.obs;

  // Submit Auction to API
  Future<void> createAuction(AddAuctionModel auction) async {
    const String apiUrl = "https://e-commerce.isotopeit.com/api/auctions";

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${_tokenService.token}', // Replace with actual token
        },
        body: jsonEncode(auction.toJson()),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          Get.snackbar("Success", responseData['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
          // Navigate to auction list or perform other actions
        } else {
          Get.snackbar("Error", responseData['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Failed to create auction",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}










 