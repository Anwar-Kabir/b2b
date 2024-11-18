// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:isotopeit_b2b/utils/url.dart';
// import 'package:isotopeit_b2b/utils/validator.dart';
// import 'package:isotopeit_b2b/view/signup/model/sign_up_model.dart';
// import 'model/district_model.dart';
// import 'model/model_division.dart';
// import 'model/upazila_model.dart';

// class SignUpController extends GetxController {
//   // Observable fields
//   var obscurePassword = true.obs;
//   var isAgreed = false.obs;
//   var isButtonEnabled = false.obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;

//   var divisions = <Division>[].obs;
//   var districts = <District>[].obs;
//   var upazilas = <Upazila>[].obs;
//   var zipCodes = <String>[].obs;
//   var selectedDivision = ''.obs;
//   var selectedDistrict = ''.obs;
//   var selectedUpazila = ''.obs;
//   var selectedZipCode = ''.obs;
//   var sameAddress = ''.obs;

//   // Loading indicators
//   var isLoadingDivisions = false.obs;
//   var isLoadingDistricts = false.obs;
//   var isLoadingUpazilas = false.obs;
//   var isLoadingZipCodes = false.obs;

//   // Form validation
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final appValidator = AppValidation();

//   // Text controllers for form fields
//   final TextEditingController sellerNameCont = TextEditingController();
//   final TextEditingController shopEmailNameCont = TextEditingController();
//   final TextEditingController slug = TextEditingController();
//   final TextEditingController tradeLicenseCont = TextEditingController();
//   final TextEditingController companyCertificationCont =
//       TextEditingController();
//   final TextEditingController cityCorporationCont = TextEditingController();
//   final TextEditingController addressLineCont = TextEditingController();
//   final TextEditingController merchantNameCont = TextEditingController();
//   final TextEditingController merchantNIDCont = TextEditingController();
//   final TextEditingController merchantPhoneCont = TextEditingController();
//   final TextEditingController merchantAddressCont = TextEditingController();
//   final TextEditingController merchantEmailCont = TextEditingController();
//   final TextEditingController merchantPasswordCont = TextEditingController();
//   final TextEditingController merchantConfirmPasswordCont =
//       TextEditingController();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchDivisions();
//   }

//   @override
//   void dispose() {
//     // Dispose controllers when the controller is destroyed
//     sellerNameCont.dispose();
//     shopEmailNameCont.dispose();
//     slug.dispose();
//     tradeLicenseCont.dispose();
//     cityCorporationCont.dispose();
//     addressLineCont.dispose();
//     merchantNameCont.dispose();
//     merchantNIDCont.dispose();
//     merchantPhoneCont.dispose();
//     merchantEmailCont.dispose();
//     merchantPasswordCont.dispose();
//     merchantConfirmPasswordCont.dispose();
//     super.dispose();
//   }

 
//   // Confirm password validation function
//   String? validateConfirmPassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please confirm your password';
//     }
//     if (value != merchantPasswordCont.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   Future<void> fetchDivisions() async {
//     await fetchData(
//         '${AppURL.baseURL}divisions', divisions, isLoadingDivisions);
//   }

//   Future<void> fetchDistricts(String division) async {
//     await fetchData(
//         '${AppURL.baseURL}districts/$division', districts, isLoadingDistricts);
//   }

//   Future<void> fetchUpazilas(String district) async {
//     await fetchData(
//         '${AppURL.baseURL}upazillas/$district', upazilas, isLoadingUpazilas);
//   }
   
//    //https://e-commerce.isotopeit.com/postcodes/Savar
//   Future<void> fetchZipCodes(String upazila) async {
//     await fetchData(
//         '${AppURL.baseURL}postcodes/$upazila', zipCodes, isLoadingZipCodes);
//   }

  

//   Future<void> fetchData(
//       String endpoint, RxList targetList, RxBool loading) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? '';

//     try {
//       loading.value = true;
//       final response = await http.get(
//         Uri.parse(endpoint),
//         headers: {
//           'Authorization': token,
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         if (endpoint.contains('divisions') && data is Map) {
//           targetList.value =
//               data.entries.map((entry) => Division(name: entry.value)).toList();
//         } else if (endpoint.contains('districts') && data is Map) {
//           targetList.value =
//               data.entries.map((entry) => District(name: entry.value)).toList();
//         } else if (endpoint.contains('upazillas') && data is Map) {
//           targetList.value =
//               data.entries.map((entry) => Upazila(name: entry.value)).toList();
//         } else if (endpoint.contains('postcodes') && data is Map) {
//           targetList.value = data.keys.toList();
//         } else {
//           throw Exception('Invalid data format');
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to load data');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred while loading data');
//     } finally {
//       loading.value = false;
//     }
//   }

//   void updateSelectedDivision(String division) {
//     selectedDivision.value = division;
//     districts.clear();
//     upazilas.clear();
//     fetchDistricts(division);
//   }

//   void updateSelectedDistrict(String district) {
//     selectedDistrict.value = district;
//     upazilas.clear();
//     fetchUpazilas(district);
//   }

//   void updateSelectedUpazila(String upazila) {
//     selectedUpazila.value = upazila;
//     fetchZipCodes(upazila);
//   }

//   void updateSelectedZipCode(String zipCode) {
//     selectedZipCode.value = zipCode;
//     fetchZipCodes(zipCode);
//   }

//    void updateSameAddress(String? value) {
//     sameAddress.value = value ?? '';
//     updateButtonState();
//   }


   
//   void togglePasswordVisibility() =>
//       obscurePassword.value = !obscurePassword.value;

//   void updateAgreement(bool? value) {
//     isAgreed.value = value ?? false;
//     updateButtonState();
//   }

//   void updateButtonState() => isButtonEnabled.value =
//       isAgreed.value && formKey.currentState?.validate() == true;

//   Future<void> handleSignup() async {
//     if (formKey.currentState?.validate() != true || !isAgreed.value) {
//       Get.snackbar("Error", "Please complete the form",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }

//     SupplierRegistrationModel registrationData = SupplierRegistrationModel(
//       shopName: sellerNameCont.text,
//       shopEmail: shopEmailNameCont.text,
//       slug: slug.text,
//       tradeLicenseNo: tradeLicenseCont.text,
//       nid: merchantNIDCont.text,
//       merchantName: merchantNameCont.text,
//       merchantPhone: merchantPhoneCont.text,
//       merchantEmail: merchantEmailCont.text,
//       division: selectedDivision.value,
//       district: selectedDistrict.value,
//       upazila: selectedUpazila.value,
//       addressLine1: addressLineCont.text,
//       postalCode: selectedZipCode.value,
//       password: merchantPasswordCont.text,
//       passwordConfirmation: merchantConfirmPasswordCont.text,
//       cityCorporationPourashova: cityCorporationCont.text,
//       sameAddress: sameAddress.value,
//     );

//     await registerSupplier(registrationData);
//   }

//   Future<void> registerSupplier(
//       SupplierRegistrationModel registrationData) async {
//     const apiUrl = "https://e-commerce.isotopeit.com/api/suppliers-register";
//     isLoading.value = true;
//     errorMessage.value = '';

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json'
//         },
//         body: jsonEncode(registrationData.toJson()),
//       );

//       if (response.statusCode == 201) {
//         Get.snackbar("Success", "Registration successful!",
//             snackPosition: SnackPosition.BOTTOM);
//       } else {
//         final errorResponse = jsonDecode(response.body);
//         errorMessage.value = errorResponse['errors'].toString();
//       }
//     } catch (e) {
//       errorMessage.value = e.toString();
//       print("Exception occurred: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/utils/validator.dart';
import 'package:isotopeit_b2b/view/signup/model/sign_up_model.dart';
import 'model/district_model.dart';
import 'model/model_division.dart';
import 'model/upazila_model.dart';

class SignUpController extends GetxController {
  var obscurePassword = true.obs;
  var isAgreed = false.obs;
  var isButtonEnabled = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var divisions = <Division>[].obs;
  var districts = <District>[].obs;
  var upazilas = <Upazila>[].obs;
  var zipCodes = <String>[].obs;
  var selectedDivision = ''.obs;
  var selectedDistrict = ''.obs;
  var selectedUpazila = ''.obs;
  var selectedZipCode = ''.obs;
  var sameAddress = ''.obs;

  var isLoadingDivisions = false.obs;
  var isLoadingDistricts = false.obs;
  var isLoadingUpazilas = false.obs;
  var isLoadingZipCodes = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final appValidator = AppValidation();

  final TextEditingController sellerNameCont = TextEditingController();
  final TextEditingController shopEmailNameCont = TextEditingController();
  final TextEditingController slug = TextEditingController();
  final TextEditingController tradeLicenseCont = TextEditingController();
  final TextEditingController companyCertificationCont =
      TextEditingController();
  final TextEditingController cityCorporationCont = TextEditingController();
  final TextEditingController addressLineCont = TextEditingController();
  final TextEditingController merchantNameCont = TextEditingController();
  final TextEditingController merchantNIDCont = TextEditingController();
  final TextEditingController merchantPhoneCont = TextEditingController();
  final TextEditingController merchantAddressCont = TextEditingController();
  final TextEditingController merchantEmailCont = TextEditingController();
  final TextEditingController merchantPasswordCont = TextEditingController();
  final TextEditingController merchantConfirmPasswordCont =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchDivisions();
  }

  @override
  void dispose() {
    sellerNameCont.dispose();
    shopEmailNameCont.dispose();
    slug.dispose();
    tradeLicenseCont.dispose();
    cityCorporationCont.dispose();
    addressLineCont.dispose();
    merchantNameCont.dispose();
    merchantNIDCont.dispose();
    merchantPhoneCont.dispose();
    merchantEmailCont.dispose();
    merchantPasswordCont.dispose();
    merchantConfirmPasswordCont.dispose();
    super.dispose();
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != merchantPasswordCont.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> fetchDivisions() async {
    await fetchData(
        '${AppURL.baseURL}divisions', divisions, isLoadingDivisions);
  }

  Future<void> fetchDistricts(String division) async {
    await fetchData(
        '${AppURL.baseURL}districts/$division', districts, isLoadingDistricts);
  }

  Future<void> fetchUpazilas(String district) async {
    await fetchData(
        '${AppURL.baseURL}upazillas/$district', upazilas, isLoadingUpazilas);
  }

  Future<void> fetchZipCodes(String upazila) async {
    await fetchData(
        '${AppURL.baseURL}postcodes/$upazila', zipCodes, isLoadingZipCodes);
  }

  Future<void> fetchData(
      String endpoint, RxList targetList, RxBool loading) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    print("Requesting data from: $endpoint");
    print("Token used in headers: $token");

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

      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Fetched data: $data");

        if (endpoint.contains('divisions') && data is Map) {
          targetList.value =
              data.entries.map((entry) => Division(name: entry.value)).toList();
        } else if (endpoint.contains('districts') && data is Map) {
          targetList.value =
              data.entries.map((entry) => District(name: entry.value)).toList();
        } else if (endpoint.contains('upazillas') && data is Map) {
          targetList.value =
              data.entries.map((entry) => Upazila(name: entry.value)).toList();
        } else if (endpoint.contains('postcodes') && data is Map) {
          targetList.value = data.keys.toList();
        } else {
          print("Unexpected data format for endpoint: $endpoint");
          throw Exception('Invalid data format');
        }
      } else {
        print("Failed response: ${response.body}");
        Get.snackbar('Error', 'Failed to load data');
      }
    } catch (e) {
      print("Exception occurred during data fetch: $e");
      Get.snackbar('Error', 'An error occurred while loading data');
    } finally {
      loading.value = false;
    }
  }

  void updateSelectedDivision(String division) {
    selectedDivision.value = division;
    districts.clear();
    upazilas.clear();
    fetchDistricts(division);
  }

  void updateSelectedDistrict(String district) {
    selectedDistrict.value = district;
    upazilas.clear();
    fetchUpazilas(district);
  }

  void updateSelectedUpazila(String upazila) {
    selectedUpazila.value = upazila;
    fetchZipCodes(upazila);
  }

  void updateSelectedZipCode(String zipCode) {
    selectedZipCode.value = zipCode;
    fetchZipCodes(zipCode);
  }

  void updateSameAddress(String? value) {
    sameAddress.value = value ?? '';
    updateButtonState();
  }

  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  void updateAgreement(bool? value) {
    isAgreed.value = value ?? false;
    updateButtonState();
  }

  void updateButtonState() => isButtonEnabled.value =
      isAgreed.value && formKey.currentState?.validate() == true;

  Future<void> handleSignup() async {
    if (formKey.currentState?.validate() != true || !isAgreed.value) {
      Get.snackbar("Error", "Please complete the form",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    SupplierRegistrationModel registrationData = SupplierRegistrationModel(
      shopName: sellerNameCont.text,
      shopEmail: shopEmailNameCont.text,
      slug: slug.text,
      tradeLicenseNo: tradeLicenseCont.text,
      nid: merchantNIDCont.text,
      merchantName: merchantNameCont.text,
      merchantPhone: merchantPhoneCont.text,
      merchantEmail: merchantEmailCont.text,
      division: selectedDivision.value,
      district: selectedDistrict.value,
      upazila: selectedUpazila.value,
      addressLine1: addressLineCont.text,
      postalCode: selectedZipCode.value,
      password: merchantPasswordCont.text,
      passwordConfirmation: merchantConfirmPasswordCont.text,
      cityCorporationPourashova: cityCorporationCont.text,
      sameAddress: sameAddress.value,
    );

    await registerSupplier(registrationData);
  }

  Future<void> registerSupplier(
      SupplierRegistrationModel registrationData) async {
    // const apiUrl = "https://e-commerce.isotopeit.com/api/suppliers-register";
    const apiUrl = "${AppURL.baseURL}api/suppliers-register";

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(registrationData.toJson()),
      );

      print("Signup response status code: ${response.statusCode}");
      print("Signup response body: ${response.body}");

      if (response.statusCode == 201) {
        Get.snackbar("Success", "Registration successful!",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        final errorResponse = jsonDecode(response.body);
        errorMessage.value = errorResponse['errors'].toString();
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print("Exception occurred during signup: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
