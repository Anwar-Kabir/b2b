import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
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
  // Initialize the controller using GetX
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

                          const LabelWithAsterisk(
                            labelText: "Wholesaler Name",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Anwar Kabir',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Shop Email",
                            isRequired: true,
                          ),

                          //Email TextField
                          CustomTextField(
                            prefixIcon: Icons.email,
                            hintText: 'anwar@gmail.com',
                            controller: signupController.appEmailValidator,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => signupController.appValidator
                                .validateEmail(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),

                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Trade License Number",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.note,
                            hintText: 'Trade License Number',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "City corporation / Pourashova*",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.map,
                            hintText: 'City corporation / Pourashova',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Company Certification",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.note_add,
                            hintText: 'Company Certification',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 2,
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Division",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Division',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            dropdownItems: [
                              const DropdownMenuItem(
                                  child: Text('Option 1'), value: '1'),
                              const DropdownMenuItem(
                                  child: Text('Option 2'), value: '2'),
                            ],
                            selectedDropdownValue: '1',
                            onDropdownChanged: (value) {
                              print('Selected: $value');
                            },
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "District",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'District',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            dropdownItems: [
                              const DropdownMenuItem(
                                  child: Text('Option 1'), value: '1'),
                              const DropdownMenuItem(
                                  child: Text('Option 2'), value: '2'),
                            ],
                            selectedDropdownValue: '1',
                            onDropdownChanged: (value) {
                              print('Selected: $value');
                            },
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Upazila",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Upazila',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            dropdownItems: [
                              const DropdownMenuItem(
                                  child: Text('Option 1'), value: '1'),
                              const DropdownMenuItem(
                                  child: Text('Option 2'), value: '2'),
                            ],
                            selectedDropdownValue: '1',
                            onDropdownChanged: (value) {
                              print('Selected: $value');
                            },
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Postal Code",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Postal Code',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            dropdownItems: [
                              const DropdownMenuItem(
                                  child: Text('Option 1'), value: '1'),
                              const DropdownMenuItem(
                                  child: Text('Option 2'), value: '2'),
                            ],
                            selectedDropdownValue: '1',
                            onDropdownChanged: (value) {
                              print('Selected: $value');
                            },
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Address Line",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Address Line',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Merchant Name",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Merchant Name',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Merchant NID",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Merchant NID',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Merchant Phone",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Merchant Phone',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Merchant Email",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Merchant Email',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
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

                          //Phone TextField
                          CustomTextField(
                            prefixIcon: Icons.phone,
                            hintText: 'Merchant Division',
                            controller: signupController.appPhoneValidator,
                            keyboardType: TextInputType.phone,
                            dropdownItems: [
                              const DropdownMenuItem(
                                  child: Text('Option 1'), value: '1'),
                              const DropdownMenuItem(
                                  child: Text('Option 2'), value: '2'),
                            ],
                            selectedDropdownValue: '1',
                            onDropdownChanged: (value) {
                              print('Selected: $value');
                            },
                            validator: (value) => signupController.appValidator
                                .validatePhoneNumber(value),
                            maxLength: 11,
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),

                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Merchant District",
                            isRequired: true,
                          ),

                          //Phone TextField
                          CustomTextField(
                            prefixIcon: Icons.phone,
                            hintText: 'Merchant District',
                            controller: signupController.appPhoneValidator,
                            keyboardType: TextInputType.phone,
                            dropdownItems: [
                              const DropdownMenuItem(
                                  child: Text('Option 1'), value: '1'),
                              const DropdownMenuItem(
                                  child: Text('Option 2'), value: '2'),
                            ],
                            selectedDropdownValue: '1',
                            onDropdownChanged: (value) {
                              print('Selected: $value');
                            },
                            validator: (value) => signupController.appValidator
                                .validatePhoneNumber(value),
                            maxLength: 11,
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),

                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Merchant Upazila",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Merchant Upazila',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            dropdownItems: [
                              const DropdownMenuItem(
                                  child: Text('Option 1'), value: '1'),
                              const DropdownMenuItem(
                                  child: Text('Option 2'), value: '2'),
                            ],
                            selectedDropdownValue: '1',
                            onDropdownChanged: (value) {
                              print('Selected: $value');
                            },
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Merchant Postal Code",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Merchant Postal Code',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            dropdownItems: [
                              const DropdownMenuItem(
                                  child: Text('Option 1'), value: '1'),
                              const DropdownMenuItem(
                                  child: Text('Option 2'), value: '2'),
                            ],
                            selectedDropdownValue: '1',
                            onDropdownChanged: (value) {
                              print('Selected: $value');
                            },
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
                          ),
                          const SizedBox(height: 20),

                          const LabelWithAsterisk(
                            labelText: "Merchant Address Line",
                            isRequired: true,
                          ),

                          //Name TextField
                          CustomTextField(
                            prefixIcon: Icons.person,
                            hintText: 'Merchant Address Line',
                            controller: signupController.appNameValidator,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => signupController.appValidator
                                .validateName(value),
                            onChanged: (value) {
                              signupController.onFieldChanged();
                            },
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
                                controller:
                                    signupController.appPasswordValidator,
                                isObscure:
                                    signupController.obscurePassword.value,
                                suffixIcon:
                                    signupController.obscurePassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                onSuffixTap: () {
                                  signupController.togglePasswordVisibility();
                                },
                                validator: (value) => signupController
                                    .appValidator
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
                                controller: signupController
                                    .appConformPasswordValidator,
                                isObscure:
                                    signupController.obscurePassword.value,
                                suffixIcon:
                                    signupController.obscurePassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                onSuffixTap: () {
                                  signupController.togglePasswordVisibility();
                                },
                                validator:
                                    signupController.validateConfirmPassword,
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
                                        text:
                                            'By signing up, you agree to the ',
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
                                            style:
                                                TextStyle(color: Colors.grey),
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
                                  onPressed:
                                      signupController.isButtonEnabled.value
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
                                              transition: Transition
                                                  .rightToLeftWithFade);
                                        }),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),
                        ])))));
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
}
