import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/view/login/login.dart';
import 'package:isotopeit_b2b/view/signup/model/district_model.dart';
import 'package:isotopeit_b2b/view/signup/model/model_division.dart';
import 'package:isotopeit_b2b/view/signup/model/upazila_model.dart';
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

  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

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
                  const SizedBox(height: 40),

                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.green[100],
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: _imageFile != null
                                ? FileImage(File(_imageFile!.path))
                                : const AssetImage(AppImages.imagebase)
                                    as ImageProvider,
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              _showImageSourceActionSheet(context);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(6),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const LabelWithAsterisk(
                    labelText: "Company Certification Attachment",
                    isRequired: true,
                  ),

                  const SizedBox(height: 20),

                  _buildTextField(
                    "Wholesaler Name",
                    Icons.person,
                    signupController.appNameValidator,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),

                  const SizedBox(height: 20),

                  _buildTextField(
                    "Shop Email",
                    Icons.person,
                    signupController.appNameValidator,
                    (value) =>
                        signupController.appValidator.validateEmail(value),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    "Trade License Number",
                    Icons.person,
                    signupController.appNameValidator,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    "City corporation / Pourashova",
                    Icons.person,
                    signupController.appNameValidator,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    "Company Certification",
                    Icons.person,
                    signupController.appNameValidator,
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
                                  value: division.name,
                                  child: Text(division.name),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            signupController.updateSelectedDivision(value!),
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
                                value: district.name,
                                child: Text(district.name),
                              ))
                          .toList(),
                      onChanged: (value) =>
                          signupController.updateSelectedDistrict(value!),
                      validator: (value) =>
                          value == null ? 'Please select a district' : null,
                    );
                  }),

                  // // Upazila Dropdown
                  Obx(() {
                    if (signupController.isLoadingUpazilas.value) {
                      return const CircularProgressIndicator();
                    }

                    return _buildDropdownField(
                      label: "Upazila",
                      icon: Icons.location_city,
                      items: signupController.upazilas
                          .map((upazila) => DropdownMenuItem(
                                value: upazila.name,
                                child: Text(upazila.name),
                              ))
                          .toList(),
                      onChanged: (value) =>
                          signupController.updateSelectedUpazila(value!),
                      validator: (value) =>
                          value == null ? 'Please select a upazila' : null,
                    );
                  }),

                  Obx(() {
                    if (signupController.isLoadingZipCodes.value) {
                      return const CircularProgressIndicator();
                    }
                    return _buildDropdownField(
                      label: "Postal Code",
                      icon: Icons.local_post_office,
                      items: signupController.zipCodes
                          .map((zipCode) => DropdownMenuItem(
                                value: zipCode,
                                child: Text(zipCode),
                              ))
                          .toList(),
                      onChanged: signupController.zipCodes.isNotEmpty
                          ? (value) {
                              print('Selected Zip Code: $value');
                            }
                          : (value) {}, // Provide an empty function if zipCodes is empty
                      validator: (value) =>
                          value == null && signupController.zipCodes.isNotEmpty
                              ? 'Please select a zip code'
                              : null,
                    );
                  }),

                  const SizedBox(height: 20),

                  _buildTextField(
                    "Address Line",
                    Icons.person,
                    signupController.appNameValidator,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    "Merchant Name",
                    Icons.person,
                    signupController.appNameValidator,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    "Merchant NID",
                    Icons.person,
                    signupController.appNameValidator,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    "Merchant Phone",
                    Icons.person,
                    signupController.appNameValidator,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    "Merchant Email",
                    Icons.person,
                    signupController.appNameValidator,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),

                  const SizedBox(height: 20),

                  const FittedBox(
                    child: LabelWithAsterisk(
                      labelText:
                          "Is the merchant's address the same as the shop's?",
                      isRequired: true,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Radio button for "Yes"
                      Radio<String>(
                        value: 'Yes',
                        groupValue: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      const Text('Yes'),
                      const SizedBox(width: 20),
                      // Radio button for "No"
                      Radio<String>(
                        value: 'No',
                        groupValue: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      const Text('No'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const LabelWithAsterisk(
                    labelText: "Merchant Division",
                    isRequired: true,
                  ),

                  //// Division
                  Obx(() {
                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.map),
                        hintText: 'Select Division',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.primaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      dropdownColor: Colors.grey,
                      items: signupController.divisions
                          .map<DropdownMenuItem<String>>((Division division) {
                        return DropdownMenuItem<String>(
                          value: division.name,
                          child: Text(division.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          signupController.updateSelectedDivision(
                              value); // Trigger district fetching
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a division';
                        }
                        return null;
                      },
                    );
                  }),

                  const SizedBox(height: 20),

                  const LabelWithAsterisk(
                    labelText: "Merchant District",
                    isRequired: true,
                  ),

                  //district TextField
                  Obx(() {
                    if (signupController.isLoadingDistricts.value) {
                      return const CircularProgressIndicator();
                    }

                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_city),
                        hintText: 'Select District',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.primaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      dropdownColor: Colors.grey,
                      items: signupController.districts
                          .map<DropdownMenuItem<String>>((District district) {
                        return DropdownMenuItem<String>(
                          value: district.name,
                          child: Text(district.name),
                        );
                      }).toList(),
                      onChanged: signupController.districts.isNotEmpty
                          ? (value) {
                              print('Selected District: $value');
                              signupController.updateSelectedDistrict(
                                  value); // Trigger Upazila fetching here
                            }
                          : null, // Disable if districts are empty
                      validator: (value) {
                        if (value == null &&
                            signupController.districts.isNotEmpty) {
                          return 'Please select a district';
                        }
                        return null;
                      },
                    );
                  }),

                  const SizedBox(height: 20),

                  const LabelWithAsterisk(
                    labelText: "Merchant Upazila",
                    isRequired: true,
                  ),

                  // Upazila Dropdown
                  Obx(() {
                    if (signupController.isLoadingUpazilas.value) {
                      return const CircularProgressIndicator();
                    }

                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on),
                        hintText: 'Select Upazila',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.primaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      dropdownColor: Colors.grey,
                      items: signupController.upazilas
                          .map<DropdownMenuItem<String>>((Upazila upazila) {
                        return DropdownMenuItem<String>(
                          value: upazila.name,
                          child: Text(upazila.name),
                        );
                      }).toList(),
                      onChanged: signupController.upazilas.isNotEmpty
                          ? (value) {
                              signupController.updateSelectedUpazila(
                                  value); // Trigger zip code fetching
                            }
                          : null, // Disable if upazilas are empty
                      validator: (value) {
                        if (value == null &&
                            signupController.upazilas.isNotEmpty) {
                          return 'Please select an upazila';
                        }
                        return null;
                      },
                    );
                  }),

                  const SizedBox(height: 20),

                  const LabelWithAsterisk(
                    labelText: "Merchant Postal Code",
                    isRequired: true,
                  ),

                  Obx(() {
                    if (signupController.isLoadingZipCodes.value) {
                      return const CircularProgressIndicator();
                    }

                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.local_post_office),
                        hintText: 'Select Zip Code',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.primaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      dropdownColor: Colors.grey,
                      items: signupController.zipCodes
                          .map<DropdownMenuItem<String>>((String zipCode) {
                        return DropdownMenuItem<String>(
                          value: zipCode,
                          child: Text(zipCode),
                        );
                      }).toList(),
                      onChanged: signupController.zipCodes.isNotEmpty
                          ? (value) {
                              print('Selected Zip Code: $value');
                            }
                          : null, // Disable if zip codes are empty
                      validator: (value) {
                        if (value == null &&
                            signupController.zipCodes.isNotEmpty) {
                          return 'Please select a zip code';
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(height: 20),

                   
                   _buildTextField(
                    "Merchant Address Line",
                    Icons.person,
                    signupController.appNameValidator,
                    (value) =>
                        signupController.appValidator.validateName(value),
                  ),
                  const SizedBox(height: 20),

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
                        controller: signupController.appPasswordValidator,
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
                          signupController.onFieldChanged();
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
                            signupController.appConformPasswordValidator,
                        isObscure: signupController.obscurePassword.value,
                        suffixIcon: signupController.obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onSuffixTap: () {
                          signupController.togglePasswordVisibility();
                        },
                        validator: signupController.validateConfirmPassword,
                        onChanged: (value) {
                          signupController.onFieldChanged();
                        },
                      )),
                  const SizedBox(height: 20),

                  // Terms and Conditions checkbox
                  Obx(() => Row(
                        children: [
                          Checkbox(
                            value: signupController.isAgreed.value,
                            onChanged: (bool? value) {
                              signupController.updateAgreement(value);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            activeColor: AppColor.primaryColor,
                          ),
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'By signing up, you agree to the ',
                                style: TextStyle(color: Colors.grey),
                                children: [
                                  TextSpan(
                                    text: 'Terms of Service ',
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'and ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),

                  // Sign up button
                  Obx(() => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: signupController.isButtonEnabled.value
                              ? () {
                                  signupController.handleSignup();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                signupController.isButtonEnabled.value
                                    ? AppColor.primaryColor
                                    : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )),
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

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
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
            signupController.onFieldChanged();
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
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor, width: 2.0),
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
