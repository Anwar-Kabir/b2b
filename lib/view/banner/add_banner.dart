import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/view/signup/signup_controller.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';

class AddBanner extends StatefulWidget {
  const AddBanner({super.key});

  @override
  State<AddBanner> createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBanner> {
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
            "Add Banner",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColor.primaryColor.withOpacity(0.7),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _controller.formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                        "Title",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
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
                    hintText: 'Title',
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
                        "Description",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),

                  //Phone TextField
                  CustomTextField(
                    prefixIcon: Icons.note,
                    maxLines: 3,
                    hintText: 'Description',
                    controller: _controller.phoneController,
                    keyboardType: TextInputType.name,
                    validator: _controller.validatePhoneNumber,
                    onChanged: (value) {
                      _controller.onFieldChanged();
                    },
                  ),
                  //
                  //
                  const SizedBox(height: 20),

                  const Row(
                    children: [
                      Text(
                        "Link",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
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
                    hintText: 'Redirect Link',
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
                        "Columns",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),

                  CustomTextField(
                    prefixIcon: Icons.email,
                    hintText: '4',
                    controller: _controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _controller.validateEmail,
                    onChanged: (value) {
                      _controller.onFieldChanged();
                    },
                  ),

                  const SizedBox(height: 20),

                  //conform password
                  const Row(
                    children: [
                      Text(
                        "Zoom effect",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),

                  CustomTextField(
                    prefixIcon: Icons.email,
                    hintText: 'no',
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
                        "Link label",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),

                  CustomTextField(
                    prefixIcon: Icons.email,
                    hintText: 'Shop Now',
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
                        "Serial Number",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),

                  CustomTextField(
                    prefixIcon: Icons.email,
                    hintText: 'Serial Number',
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
                        "Background",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),

                  CustomTextField(
                    prefixIcon: Icons.email,
                    hintText: '#ab7553',
                    controller: _controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _controller.validateEmail,
                    onChanged: (value) {
                      _controller.onFieldChanged();
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () {
              // Add Save functionality
            },
            icon: const Icon(Icons.save),
            label: const Text("Save"),
            style: ElevatedButton.styleFrom(
              minimumSize:
                  const Size(double.infinity, 50), // Make button full-width
              backgroundColor:
                  AppColor.primaryColor, // Change this to your desired color
              // For text color:
              foregroundColor: Colors.white, // Text and icon color
            ),
          ),
        ));
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
