import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/utils/validator.dart';
import 'package:isotopeit_b2b/view/login/login.dart';
import 'package:isotopeit_b2b/view/signup/model/postal_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/district_model.dart';
import 'model/model_division.dart';
import 'model/upazila_model.dart';

class SignUpController extends GetxController {
  // Observable variables
  var obscurePassword = true.obs;
  var obscureComformPassword = true.obs;
  var isAgreed = false.obs;
  var isButtonEnabled = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Dropdown-related lists
  var divisions = <Division>[].obs;
  var districts = <District>[].obs;
  var upazilas = <Upazila>[].obs;
  var zipCodes = <PostCode>[].obs; // Changed to handle PostCode objects
  var selectedDivision = ''.obs;
  var selectedDistrict = ''.obs;
  var selectedUpazila = ''.obs;
  var selectedZipCode = ''.obs;
  var sameAddress = ''.obs;

  // Loading indicators
  var isLoadingDivisions = false.obs;
  var isLoadingDistricts = false.obs;
  var isLoadingUpazilas = false.obs;
  var isLoadingZipCodes = false.obs;

  // Form key and validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final appValidator = AppValidation();

  // Controllers for form fields
  final TextEditingController shopName = TextEditingController();
  final TextEditingController merchantName = TextEditingController();
  final TextEditingController merchantPhone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController interestedArea = TextEditingController();
  final TextEditingController merchantPasswordCont = TextEditingController();
  final TextEditingController merchantConfirmPasswordCont =
      TextEditingController();

  var isAgreedToTerms = false.obs;

  // Method to update the agreement status
  void updateAgreement(bool value) {
    isAgreedToTerms.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    fetchDivisions();
  }

  @override
  void dispose() {
    shopName.dispose();
    merchantName.dispose();
    merchantPhone.dispose();
    address.dispose();
    interestedArea.dispose();
    merchantConfirmPasswordCont.dispose();
    super.dispose();
  }

  // Validation for password confirmation
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != merchantPasswordCont.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Fetch divisions
  Future<void> fetchDivisions() async {
    await fetchData(
        '${AppURL.baseURL}divisions', divisions, isLoadingDivisions);
  }

  // Fetch districts
  Future<void> fetchDistricts(String divisionId) async {
    await fetchData('${AppURL.baseURL}districts/$divisionId', districts,
        isLoadingDistricts);
  }

  // Fetch upazilas
  Future<void> fetchUpazilas(String districtId) async {
    await fetchData(
        '${AppURL.baseURL}upazillas/$districtId', upazilas, isLoadingUpazilas);
  }

  // Fetch postcodes
  Future<void> fetchZipCodes(String upazilaId) async {
    await fetchData(
        '${AppURL.baseURL}postcodes/$upazilaId', zipCodes, isLoadingZipCodes);
  }

  // General fetch data method
  Future<void> fetchData(
      String endpoint, RxList targetList, RxBool loading) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      loading.value = true;
      final response = await http.get(
        Uri.parse(endpoint),
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (endpoint.contains('divisions') && data is List) {
          targetList.value = Division.fromJsonList(data);
        } else if (endpoint.contains('districts') && data is List) {
          targetList.value = District.fromJsonList(data);
        } else if (endpoint.contains('upazillas') && data is List) {
          targetList.value = Upazila.fromJsonList(data);
        } else if (endpoint.contains('postcodes') && data is List) {
          targetList.value =
              PostCode.fromJsonList(data); // Correctly handles PostCode objects
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to load data',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while loading data $e');
    } finally {
      loading.value = false;
    }
  }

  // Update selected dropdown values
  void updateSelectedDivision(String divisionId) {
    selectedDivision.value = divisionId;
    districts.clear();
    upazilas.clear();
    fetchDistricts(divisionId);
  }

  void updateSelectedDistrict(String districtId) {
    selectedDistrict.value = districtId;
    upazilas.clear();
    fetchUpazilas(districtId);
  }

  void updateSelectedUpazila(String upazilaId) {
    selectedUpazila.value = upazilaId;
    fetchZipCodes(upazilaId);
  }

  void updateSelectedZipCode(String zipCode) {
    selectedZipCode.value = zipCode;
  }

  // Password visibility toggle
  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  void toggleConformPasswordVisibility() =>
      obscureComformPassword.value = !obscureComformPassword.value;

  // Handle form submission

  Future<void> registerSupplier(Map<String, dynamic> registrationData) async {
    const apiUrl = "${AppURL.baseURL}api/suppliers-register";

    isLoading.value = true;
    errorMessage.value =
        ''; // Reset error message before starting the API call.

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(registrationData),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Registration successful!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(Login(), transition: Transition.leftToRightWithFade);
      } else {
        // Parse and display specific error messages.
        final errorResponse = jsonDecode(response.body);
        print(errorResponse);
        if (errorResponse['errors'] != null) {
          errorMessage.value = errorResponse['errors'].toString();
        } else if (errorResponse['message'] != null) {
          errorMessage.value = errorResponse['message'];
        } else {
          errorMessage.value = "Registration failed. Please try again.";
        }
        print(errorMessage.value);
        Get.snackbar(
          "Error ",
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage.value = "An unexpected error occurred: $e";
      print(errorMessage.value);
      Get.snackbar(
        "Error",
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
