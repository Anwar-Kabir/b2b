import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/utils/string.dart';
import 'package:isotopeit_b2b/view/login/login.dart';
import 'package:isotopeit_b2b/view/signup/signup_controller.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // Initialize the controller using GetX
  final SignupController _controller = Get.put(SignupController());

  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;

  final _formKey = GlobalKey<FormState>();
  // GlobalKey for form validation
  final TextEditingController _zipController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
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
            key: _controller.formKey,
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

                const Row(
                  children: [
                    Text(
                      "Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),

                //Name TextField
                CustomTextField(
                  prefixIcon: Icons.person,
                  hintText: 'Anwar Kabir',
                  controller: _controller.nameController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _controller.validateName,
                  onChanged: (value) {
                    _controller.onFieldChanged();
                  },
                ),
                const SizedBox(height: 20),

                const Row(
                  children: [
                    Text(
                      "Phone",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),

                //Phone TextField
                CustomTextField(
                  prefixIcon: Icons.phone,
                  hintText: '01000000000',
                  controller: _controller.phoneController,
                  keyboardType: TextInputType.phone,
                  validator: _controller.validatePhoneNumber,
                  maxLength: 11,
                  onChanged: (value) {
                    _controller.onFieldChanged();
                  },
                ),
                // const SizedBox(height: 20),

                const Row(
                  children: [
                    Text(
                      AppStrings.loginEmail,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),

                //Email TextField
                CustomTextField(
                  prefixIcon: Icons.email,
                  hintText: 'anwar@gmail.com',
                  controller: _controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _controller.validateEmail,
                  onChanged: (value) {
                    _controller.onFieldChanged();
                  },
                ),
                const SizedBox(height: 20),

                //password
                const Row(
                  children: [
                    Text(
                      AppStrings.loginPassword,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),

                Obx(() => CustomTextField(
                      prefixIcon: Icons.lock,
                      maxLines: 1,
                      hintText: '#33anwar',
                      controller: _controller.passwordController,
                      isObscure: _controller.obscurePassword.value,
                      suffixIcon: _controller.obscurePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixTap: () {
                        _controller.togglePasswordVisibility();
                      },
                      validator: _controller.validatePassword,
                      onChanged: (value) {
                        _controller.onFieldChanged();
                      },
                    )),
                const SizedBox(height: 20),

                //conform password
                const Row(
                  children: [
                    Text(
                      "Conform Password",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),

                // Password TextField with toggle visibility
                Obx(() => CustomTextField(
                      prefixIcon: Icons.lock,
                      hintText: '#33anwar',
                      maxLines: 1,
                      controller: _controller.conformpasswordController,
                      isObscure: _controller.obscurePassword.value,
                      suffixIcon: _controller.obscurePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixTap: () {
                        _controller.togglePasswordVisibility();
                      },
                      validator: _controller.validateConfirmPassword,
                      onChanged: (value) {
                        _controller.onFieldChanged();
                      },
                    )),
                const SizedBox(height: 20),

                // Terms and Conditions checkbox
                Obx(() => Row(
                      children: [
                        Checkbox(
                          value: _controller.isAgreed.value,
                          onChanged: (bool? value) {
                            _controller.updateAgreement(value);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: const Color(0xFF7F56D9),
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
                                    color: Color(0xFF7F56D9),
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
                                    color: Color(0xFF7F56D9),
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
                        onPressed: _controller.isButtonEnabled.value
                            ? () {
                                _controller.handleSignup();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _controller.isButtonEnabled.value
                              ? const Color(0xFF7F56D9)
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
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
                              color: Color(0xFF7F56D9),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(const Login(),
                                    transition: Transition.rightToLeftWithFade);
                              }),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
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
}
