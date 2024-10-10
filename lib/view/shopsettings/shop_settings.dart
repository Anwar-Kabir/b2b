import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/utils/string.dart';
import 'package:isotopeit_b2b/view/login/login.dart';
import 'package:isotopeit_b2b/view/signup/signup_controller.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';

class ShopSettingsPage extends StatefulWidget {
  ShopSettingsPage({super.key});

  @override
  State<ShopSettingsPage> createState() => _ShopSettingsPageState();
}

class _ShopSettingsPageState extends State<ShopSettingsPage> {
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
        title: Text("Shop Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),

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
                      "Shop Name",
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
                  labelText: 'Shop Name',
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
                  labelText: 'Phone',
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
                  labelText: 'Email',
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
                      "Address",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),

                CustomTextField(
                  prefixIcon: Icons.email,
                  labelText: 'Address',
                  controller: _controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _controller.validateEmail,
                  onChanged: (value) {
                    _controller.onFieldChanged();
                  },
                ),
                const SizedBox(height: 20),

                Text(
                  "Bank Deatils",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),

                SizedBox(
                  height: 5,
                ),

                
                
                const Row(
                  children: [
                    Text(
                      "Bank Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),

                CustomTextField(
                  prefixIcon: Icons.email,
                  labelText: 'Bank Name',
                  controller: _controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _controller.validateEmail,
                  onChanged: (value) {
                    _controller.onFieldChanged();
                  },
                ),
                const SizedBox(height: 20),



                const Row(
                  children: [
                    Text(
                      "Account Number",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),

                CustomTextField(
                  prefixIcon: Icons.email,
                  labelText: 'Account Number',
                  controller: _controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _controller.validateEmail,
                  onChanged: (value) {
                    _controller.onFieldChanged();
                  },
                ),
                const SizedBox(height: 20),

                const Row(
                  children: [
                    Text(
                      "Routing Number",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),

                CustomTextField(
                  prefixIcon: Icons.email,
                  labelText: 'Routing Number',
                  controller: _controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _controller.validateEmail,
                  onChanged: (value) {
                    _controller.onFieldChanged();
                  },
                ),
                const SizedBox(height: 20),

                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7F56D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

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
