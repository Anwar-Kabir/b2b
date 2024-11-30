import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/login/login.dart';
import 'package:isotopeit_b2b/view/signup/signup_controller.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController signupController = Get.put(SignUpController());

  String? selectedValue = 'No';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: signupController.formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),

                  _buildTextField(
                    "Shop Name",
                    Icons.person,
                    signupController.shopName,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),

                  const SizedBox(height: 20),

                  _buildTextField(
                    "Merchant Name",
                    Icons.person,
                    signupController.merchantName,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),

                  const SizedBox(height: 20),

                  _buildTextField(
                    "Merchant Phone",
                    Icons.person,
                    signupController.merchantPhone,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),

                  const SizedBox(height: 20),

                  // Division Dropdown
                  Obx(() => _buildDropdownField(
                        label: "Division",
                        icon: Icons.map,
                        items: signupController.divisions
                            .map((division) => DropdownMenuItem(
                                  value: division.id
                                      .toString(), // Use ID for selection
                                  child: Text(division.text),
                                ))
                            .toList(),
                        onChanged: (value) => signupController
                            .updateSelectedDivision(value!), // Trigger fetch
                        validator: (value) =>
                            value == null ? 'Please select a division' : null,
                      )),

                  // District Dropdown
                  Obx(() {
                    if (signupController.isLoadingDistricts.value) {
                      return const CircularProgressIndicator();
                    }
                    return _buildDropdownField(
                      label: "District",
                      icon: Icons.location_city,
                      items: signupController.districts
                          .map((district) => DropdownMenuItem(
                                value: district.id
                                    .toString(), // Use ID for selection
                                child: Text(district.text),
                              ))
                          .toList(),
                      onChanged: (value) =>
                          signupController.updateSelectedDistrict(
                              value!), // Update selected district
                      validator: (value) =>
                          value == null ? 'Please select a district' : null,
                    );
                  }),

                  //upzila dropdown
                  Obx(() {
                    // Check if the user has selected a district
                    if (signupController.selectedDistrict.value == null) {
                      return const Text('Please select a district first');
                    }

                    // Check if upazilas are loading
                    if (signupController.isLoadingUpazilas.value) {
                      return const CircularProgressIndicator();
                    }

                    return _buildDropdownField(
                      label: "Upazila",
                      icon: Icons.location_city,
                      items: signupController.upazilas
                          .map((upazila) => DropdownMenuItem<String>(
                                value: upazila.id
                                    .toString(), // Pass the ID here instead of text
                                child: Text(upazila.text),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          signupController
                              .updateSelectedUpazila(value); // Update with ID
                        }
                      },
                      validator: (value) =>
                          value == null ? 'Please select an upazila' : null,
                    );
                  }),

                  // Postal code dropdown
                  Obx(() {
                    if (signupController.isLoadingZipCodes.value) {
                      return const CircularProgressIndicator(); // Show loading spinner while zip codes are being fetched.
                    }

                    return _buildDropdownField(
                      label: "Postal Code",
                      icon: Icons.local_post_office,
                      items: signupController.zipCodes
                          .map((zipCode) => DropdownMenuItem<String>(
                                value: zipCode.id
                                    .toString(), // Pass the ID of the zip code here
                                child: Text(zipCode.text),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          signupController.updateSelectedZipCode(value);
                          print('Selected Zip Code ID: $value');
                        }
                      },
                      validator: (value) => (value == null || value.isEmpty) &&
                              signupController.zipCodes.isNotEmpty
                          ? 'Please select a postal code'
                          : null,
                    );
                  }),

                  _buildTextField(
                    "Address",
                    Icons.person,
                    signupController.address,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    "Interested Area",
                    Icons.person,
                    signupController.interestedArea,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),

                  //password
                  const LabelWithAsterisk(
                    labelText: "Password",
                    isRequired: true,
                  ),

                  //password
                  Obx(() => CustomTextField(
                        prefixIcon: Icons.lock,
                        maxLines: 1,
                        hintText: '#33anwar',
                        controller: signupController.merchantPasswordCont,
                        isObscure: signupController.obscurePassword.value,
                        suffixIcon: signupController.obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onSuffixTap: () {
                          signupController.togglePasswordVisibility();
                        },
                        validator: (value) => signupController.appValidator
                            .validatePassword(value),
                        onChanged: (value) {
                          //signupController.onFieldChanged();
                        },
                      )),
                  const SizedBox(height: 20),

                  //conform password
                  const LabelWithAsterisk(
                    labelText: "Conform Password",
                    isRequired: true,
                  ),

                  // Password TextField with toggle visibility
                  Obx(() => CustomTextField(
                        prefixIcon: Icons.lock,
                        hintText: '#33anwar',
                        maxLines: 1,
                        controller:
                            signupController.merchantConfirmPasswordCont,
                        isObscure:
                            signupController.obscureComformPassword.value,
                        suffixIcon:
                            signupController.obscureComformPassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                        onSuffixTap: () {
                          signupController.toggleConformPasswordVisibility();
                        },
                        validator: signupController.validateConfirmPassword,
                        onChanged: (value) {
                          //signupController.onFieldChanged();
                        },
                      )),
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),

                 

                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (signupController.formKey.currentState
                                  ?.validate() ??
                              false) {
                            signupController.registerSupplier({
                              'shop_name': signupController.shopName.text,
                              'merchant_name': signupController
                                  .merchantName.text, // Fixed here
                              'merchant_phone':
                                  signupController.merchantPhone.text,
                              'address_line1': signupController.address.text,
                              'interested_area':
                                  signupController.interestedArea.text,
                              'division': signupController.selectedDivision
                                  .value, // Ensure correct values
                              'district':
                                  signupController.selectedDistrict.value,
                              'upazila': signupController.selectedUpazila.value,
                              'postal_code':
                                  signupController.selectedZipCode.value,
                              'password':
                                  signupController.merchantPasswordCont.text,
                              'password_confirmation': signupController
                                  .merchantConfirmPasswordCont.text,
                            });
                          } else {
                            print("Form is invalid");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: signupController.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white))
                            : const Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Already have an account? Login
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                              text: 'Login',
                              style: const TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(const Login(),
                                      transition:
                                          Transition.rightToLeftWithFade);
                                }),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    TextEditingController controller,
    String? Function(String?)? validator, // Ensure return type is `String?`
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWithAsterisk(labelText: label, isRequired: true),
        const SizedBox(height: 8),
        CustomTextField(
          prefixIcon: icon,
          hintText: label,
          controller: controller,
          validator: validator,
          onChanged: (value) {
            //signupController.onFieldChanged();
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWithAsterisk(labelText: label, isRequired: true),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: label, // Show the label as hint text in the dropdown
            hintStyle: TextStyle(
                color: Colors.grey), // Adjust hint text style if needed
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red, width: 2.0), // Error border color
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red, width: 2.0), // Error border when focused
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          items: items,
          onChanged: onChanged,
          validator: validator,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
