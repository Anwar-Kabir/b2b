import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/utils/string.dart';
import 'package:isotopeit_b2b/view/signup/signup_controller.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';

class ShopSettingsPage extends StatefulWidget {
  ShopSettingsPage({super.key});

  @override
  State<ShopSettingsPage> createState() => _ShopSettingsPageState();
}

class _ShopSettingsPageState extends State<ShopSettingsPage> {
  final SignupController _controller = Get.put(SignupController());
  final ImagePicker _picker = ImagePicker();
  XFile? _logoImageFile;
  XFile? _coverImageFile;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _zipController = TextEditingController();

  Future<void> _pickImage(ImageSource source, String imageType) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (imageType == 'logo') {
          _logoImageFile = pickedFile;
        } else if (imageType == 'cover') {
          _coverImageFile = pickedFile;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shop Settings"),
          bottom: TabBar(
            tabs: [
              Tab(text: 'General'),
              Tab(text: 'Image'),
              Tab(text: 'Address'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TabBarView(
            children: [
              // General Tab (left unchanged)
              _buildGeneralTab(),

              // Image Tab with two image pickers
              _buildImageTab(),

              // Address Tab (left unchanged)
              _buildAddressTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      child: Form(
        key: _controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            const LabelWithAsterisk(
              labelText: "Shop Name",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.person,
              labelText: 'Shop Name',
              hintText: "Ak Shop",
              controller: _controller.nameController,
              validator: _controller.validateName,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Slug",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.note_add,
              hintText: "Slug",
              controller: _controller.phoneController,
              keyboardType: TextInputType.phone,
              validator: _controller.validatePhoneNumber,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Full Name (Trade License)",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.people,
              hintText: 'Full Name (Trade License',
              controller: _controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _controller.validateEmail,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Trade license no:",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.info,
              hintText: 'Trade license',
              controller: _controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _controller.validateEmail,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Email address:",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.email,
              hintText: 'ak@gmail.com',
              controller: _controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _controller.validateEmail,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "External url:",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.library_add,
              hintText: 'External url',
              controller: _controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _controller.validateEmail,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Description:",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.note_alt,
              hintText: 'Description',
              maxLines: 3,
              controller: _controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _controller.validateEmail,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Return & refund policy:",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.note_sharp,
              hintText: 'Return & refund policy',
              maxLines: 3,
              controller: _controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _controller.validateEmail,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
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
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageTab() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Logo Image
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.green[100],
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _logoImageFile != null
                        ? FileImage(File(_logoImageFile!.path))
                        : const AssetImage(AppImages.imagebase)
                            as ImageProvider,
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _showImageSourceActionSheet(context, 'logo'),
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
            const SizedBox(height: 20),
            const Text("Logo Image"),

            const SizedBox(height: 20),
            // Cover Image
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.green[100],
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _coverImageFile != null
                        ? FileImage(File(_coverImageFile!.path))
                        : const AssetImage(AppImages.imagebase)
                            as ImageProvider,
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _showImageSourceActionSheet(context, 'cover'),
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
            const SizedBox(height: 20),
            const Text("Cover Image"),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressTab() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Form(
        key: _controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            const LabelWithAsterisk(
              labelText: "Division",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.location_city_rounded,
              hintText: "Division",
              controller: _controller.nameController,
              validator: _controller.validateName,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "District",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.note_add,
              hintText: "District",
              controller: _controller.phoneController,
              keyboardType: TextInputType.phone,
              validator: _controller.validatePhoneNumber,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Upazila",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.map,
              hintText: 'Upazila',
              controller: _controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _controller.validateEmail,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Address Line",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.info,
              hintText: 'Address Line',
              controller: _controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _controller.validateEmail,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Zip Code",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.maps_ugc_sharp,
              hintText: 'Zip Code',
              controller: _controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _controller.validateEmail,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Phone",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.phone,
              hintText: 'Phone',
              controller: _controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _controller.validateEmail,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
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
            const SizedBox(
              height: 20,
            )
          ],
        ),
      )
    ]));
  }

  void _showImageSourceActionSheet(BuildContext context, String imageType) {
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
                  _pickImage(ImageSource.gallery, imageType);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera, imageType);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
