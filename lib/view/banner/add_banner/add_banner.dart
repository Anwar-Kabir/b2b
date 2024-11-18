import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/utils/validator.dart';
import 'package:isotopeit_b2b/view/banner/add_banner/add_banner_controller.dart';
import 'package:isotopeit_b2b/view/banner/banner/banner.dart';
import 'package:isotopeit_b2b/view/banner/banner/controller_banner.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';

class AddBanner extends StatefulWidget {
  const AddBanner({super.key});

  @override
  State<AddBanner> createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBanner> {
  final AddBannerController _controller = Get.put(AddBannerController());
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? _imageError; // Error message for image validation

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    setState(() {
      _imageFile = pickedFile;
      _imageError = null; // Clear error if an image is picked
      if (_imageFile != null) {
        _controller.setFeatureImagePath(pickedFile!.path);
      }
    });
  }

  // Function to validate if an image is selected
  bool _validateImage() {
    if (_imageFile == null) {
      setState(() {
        _imageError = 'Please select an image'; // Set error message
      });
      return false;
    } else {
      setState(() {
        _imageError = null; // Clear error if validation passes
      });
      return true;
    }
  }

  void _clearForm() {
    _controller.titleController.clear();
    _controller.descriptionController.clear();
    _controller.linkController.clear();
    _controller.linkLabelController.clear();
    _controller.bgColorController.clear();
    _controller.columnsController.clear();
    _controller.orderController.clear();
    _controller.effectController.clear();
    setState(() {
      _imageFile = null;
      _controller.setFeatureImagePath(''); // Clear the image path
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Banner", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                              : const AssetImage(AppImages.splashLogo)
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
                if (_imageError != null) // Display image error message if any
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Text(
                        _imageError!,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                const LabelWithAsterisk(labelText: "Title", ),
                CustomTextField(
                  prefixIcon: Icons.person,
                  hintText: 'Title',
                  controller: _controller.titleController,
                  keyboardType: TextInputType.name,
                  // validator: (value) =>
                  //     AppValidation().validateText(value, 'Title'),
                ),
                const SizedBox(height: 20),
                const LabelWithAsterisk(
                    labelText: "Description", ),
                CustomTextField(
                  prefixIcon: Icons.description,
                  hintText: 'Description',
                  controller: _controller.descriptionController,
                  keyboardType: TextInputType.text,
                  // validator: (value) =>
                  //     AppValidation().validateText(value, 'Description'),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                const LabelWithAsterisk(
                    labelText: "Redirect Link", ),
                CustomTextField(
                  prefixIcon: Icons.person,
                  hintText: 'Redirect Link',
                  controller: _controller.linkController,
                  keyboardType: TextInputType.name,
                  // validator: (value) => AppValidation()
                  //     .validateText(value, 'Redirect Link'), // Pass field label
                ),
                const SizedBox(height: 20),
                const LabelWithAsterisk(labelText: "Columns", ),
                CustomTextField(
                  prefixIcon: Icons.person,
                  hintText: '4',
                  controller: _controller.columnsController,
                  keyboardType: TextInputType.name,
                  // validator: (value) => AppValidation()
                  //     .validateText(value, 'Colum'), // Pass field label
                ),
                const SizedBox(height: 20),
                const LabelWithAsterisk(
                    labelText: "Zoom effect", ),
                CustomTextField(
                  prefixIcon: Icons.zoom_in,
                  hintText: 'no',
                  controller: _controller.effectController,
                  keyboardType: TextInputType.name,
                  // validator: (value) =>
                  //     AppValidation().validateText(value, 'Zoom effect'),
                ),
                const SizedBox(height: 20),
                const LabelWithAsterisk(
                    labelText: "Link Label", ),
                CustomTextField(
                  prefixIcon: Icons.label,
                  hintText: 'Shop Now',
                  controller: _controller.linkLabelController,
                  keyboardType: TextInputType.name,
                  // validator: (value) =>
                  //     AppValidation().validateText(value, 'Link Label'),
                ),
                const SizedBox(height: 20),
                const LabelWithAsterisk(
                    labelText: "Serial Number", ),
                CustomTextField(
                  prefixIcon: Icons.format_list_numbered,
                  hintText: 'Serial Number',
                  controller: _controller.orderController,
                  keyboardType: TextInputType.number,
                  // validator: (value) =>
                  //     AppValidation().validateText(value, 'Serial Number'),
                ),
                const SizedBox(height: 20),
                const LabelWithAsterisk(
                    labelText: "Background", ),
                CustomTextField(
                  prefixIcon: Icons.color_lens,
                  hintText: '#ab7553',
                  controller: _controller.bgColorController,
                  keyboardType: TextInputType.text,
                  // validator: (value) =>
                  //     AppValidation().validateText(value, 'Background'),
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
          onPressed: () async {
            

            final isFormValid = _formKey.currentState?.validate() ?? false;
            final isImageValid = _validateImage();

            if (isFormValid && isImageValid) {
              final isSuccess = await _controller.createBanner();
              if (isSuccess) {
                _clearForm();
                 // Retrieve the existing instance of BannerController and refresh the banners
                final BannerController bannerController =
                    Get.find<BannerController>();
                await bannerController.fetchBanners();
                Get.to(BannerManager(),
                    transition: Transition.rightToLeftWithFade);
                    
              } else {
                // Handle unsuccessful attempts here if needed
              }
            } else {
              // Optionally show a snackbar or another notification for form validation issues
            }
          },
          icon: const Icon(Icons.save),
          label: const Text("Save"),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: AppColor.primaryColor,
            foregroundColor: Colors.white,
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
