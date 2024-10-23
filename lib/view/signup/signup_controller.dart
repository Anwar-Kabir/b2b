import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/validator.dart';
import 'package:isotopeit_b2b/view/login/login.dart';
import 'package:isotopeit_b2b/view/signup/model/district_model.dart';
import 'package:isotopeit_b2b/view/signup/model/model_division.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/view/signup/model/upazila_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  // Variables
  var obscurePassword = true.obs;
  var isAgreed = false.obs;
  var isButtonEnabled = false.obs;

  var divisions = <Division>[].obs;
  var isLoading = false.obs;

  var districts = <District>[].obs;
  var isLoadingDistricts = false.obs;
  var selectedDivision = ''.obs; 

  var upazilas = <Upazila>[].obs;
  var isLoadingUpazilas = false.obs;
  var selectedDistrict = ''.obs;

  var zipCodes = <String>[].obs; // To hold the zip codes
  var isLoadingZipCodes = false.obs;
  var selectedUpazila = ''.obs; // To store selected upazila

  // Form validation key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   final GlobalKey<FormState> bannerKey = GlobalKey<FormState>();

  

  @override
  void onInit() {
    super.onInit();
    fetchDivisions();
  }

 
  //app validation from
  final appValidator = AppValidation();
  final appNameValidator = TextEditingController();
  final appPhoneValidator = TextEditingController();
  final appEmailValidator = TextEditingController();
  final appPasswordValidator = TextEditingController();
  final appConformPasswordValidator = TextEditingController();

  @override
  void dispose() {
    appNameValidator.dispose();
    appPhoneValidator.dispose();
    appEmailValidator.dispose();
    appPasswordValidator.dispose();
    appConformPasswordValidator.dispose();
    super.dispose();
  }

  // Confirm password validation function
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != appPasswordValidator.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Update agreement status
  void updateAgreement(bool? value) {
    isAgreed.value = value ?? false;
    updateButtonState();
  }

  // Update button state based on form and agreement
  void updateButtonState() {
    isButtonEnabled.value =
        isAgreed.value && formKey.currentState?.validate() == true;
  }

 
  void onFieldChanged() {
    formKey.currentState?.validate();

    updateButtonState();
  }

  // Handle the sign-up logic
  Future<void> handleSignup() async {
    if (formKey.currentState!.validate() && isAgreed.value) {
      Get.snackbar("Success", "Sign up successful!",
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.offAll(const Login());
    } else {
      Get.snackbar("Error", "Please complete the form",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }


  ///===> Divisions
  Future<void> fetchDivisions() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://e-commerce.isotopeit.com/divisions'),
        headers: {
          'Authorization':
              token,  
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        divisions(Division.fromJsonList(data));
      } else {
        Get.snackbar('Error', 'Failed to load divisions');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  
   // Fetch districts based on selected division
   // Fetch districts based on the selected division
  Future<void> fetchDistricts(String divisionName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      isLoadingDistricts(true);
      final response = await http.get(
        Uri.parse('https://e-commerce.isotopeit.com/districts/$divisionName'),
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        districts(District.fromJsonList(data));
      } else {
        Get.snackbar('Error', 'Failed to load districts');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingDistricts(false);
    }
  }


  // Fetch Upazilas based on the selected district
  Future<void> fetchUpazilas(String districtName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      isLoadingUpazilas(true);
      final response = await http.get(
        Uri.parse('https://e-commerce.isotopeit.com/upazillas/$districtName'),
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        upazilas(Upazila.fromJsonList(data));
      } else {
        Get.snackbar('Error', 'Failed to load upazilas');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingUpazilas(false);
    }
  }


    // Fetch Zip Codes based on the selected Upazila
  Future<void> fetchZipCodes(String upazilaName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      isLoadingZipCodes(true);
      final response = await http.get(
        Uri.parse('https://e-commerce.isotopeit.com/postcodes/$upazilaName'),
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        // Extract keys (zip codes) from the response and update the observable list
        zipCodes.value = data.keys.toList();
      } else {
        Get.snackbar('Error', 'Failed to load zip codes');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingZipCodes(false);
    }
  }

  // Update selected upazila and fetch corresponding zip codes
  void updateSelectedUpazila(String? upazilaName) {
    if (upazilaName != null) {
      selectedUpazila.value = upazilaName;
      fetchZipCodes(upazilaName); // Trigger zip code fetching
    }
  }


  // Update selected district and fetch corresponding upazilas
  void updateSelectedDistrict(String? districtName) {
    if (districtName != null) {
      selectedDistrict.value = districtName;
      fetchUpazilas(districtName);
    }
  }


  // Update selected division and fetch corresponding districts
  void updateSelectedDivision(String? divisionName) {
    if (divisionName != null) {
      selectedDivision.value = divisionName;
      fetchDistricts(divisionName);
    }
  }
}
