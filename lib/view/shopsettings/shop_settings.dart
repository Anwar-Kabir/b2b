// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:isotopeit_b2b/utils/color.dart';
// import 'package:isotopeit_b2b/utils/image.dart';
// import 'package:isotopeit_b2b/utils/string.dart';
// import 'package:isotopeit_b2b/view/signup/signup_controller.dart';
// import 'package:isotopeit_b2b/widget/custom_text_field.dart';
// import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';

// class ShopSettingsPage extends StatefulWidget {
//   ShopSettingsPage({super.key});

//   @override
//   State<ShopSettingsPage> createState() => _ShopSettingsPageState();
// }

// class _ShopSettingsPageState extends State<ShopSettingsPage> {
//   final SignupController _controller = Get.put(SignupController());
//   final ImagePicker _picker = ImagePicker();
//   XFile? _logoImageFile;
//   XFile? _coverImageFile;
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _zipController = TextEditingController();

//   Future<void> _pickImage(ImageSource source, String imageType) async {
//     final XFile? pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         if (imageType == 'logo') {
//           _logoImageFile = pickedFile;
//         } else if (imageType == 'cover') {
//           _coverImageFile = pickedFile;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3, // Number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Shop Settings"),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'General'),
//               Tab(text: 'Image'),
//               Tab(text: 'Address'),
//             ],
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: TabBarView(
//             children: [
//               // General Tab (left unchanged)
//               _buildGeneralTab(),

//               // Image Tab with two image pickers
//               _buildImageTab(),

//               // Address Tab (left unchanged)
//               _buildAddressTab(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGeneralTab() {
//     return SingleChildScrollView(
//       child: Form(
//         key: _controller.formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const SizedBox(height: 30),
//             const LabelWithAsterisk(
//               labelText: "Shop Name",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.person,
//               labelText: 'Shop Name',
//               hintText: "Ak Shop",
//               controller: _controller.nameController,
//               validator: _controller.validateName,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "Slug",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.note_add,
//               hintText: "Slug",
//               controller: _controller.phoneController,
//               keyboardType: TextInputType.phone,
//               validator: _controller.validatePhoneNumber,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "Full Name (Trade License)",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.people,
//               hintText: 'Full Name (Trade License',
//               controller: _controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: _controller.validateEmail,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "Trade license no:",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.info,
//               hintText: 'Trade license',
//               controller: _controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: _controller.validateEmail,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "Email address:",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.email,
//               hintText: 'ak@gmail.com',
//               controller: _controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: _controller.validateEmail,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "External url:",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.library_add,
//               hintText: 'External url',
//               controller: _controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: _controller.validateEmail,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "Description:",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.note_alt,
//               hintText: 'Description',
//               maxLines: 3,
//               controller: _controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: _controller.validateEmail,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "Return & refund policy:",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.note_sharp,
//               hintText: 'Return & refund policy',
//               maxLines: 3,
//               controller: _controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: _controller.validateEmail,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ElevatedButton.icon(
//               onPressed: () {
//                 // Add Save functionality
//               },
//               icon: const Icon(Icons.save),
//               label: const Text("Save"),
//               style: ElevatedButton.styleFrom(
//                 minimumSize:
//                     const Size(double.infinity, 50), // Make button full-width
//                 backgroundColor:
//                     AppColor.primaryColor, // Change this to your desired color
//                 // For text color:
//                 foregroundColor: Colors.white, // Text and icon color
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImageTab() {
//     return SingleChildScrollView(
//       child: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 30),
//             // Logo Image

//             Stack(
//               alignment: Alignment.bottomRight,
//               children: [
//                 Container(
//                   width: double.infinity, // Set desired width
//                   height: 150, // Set desired height
//                   decoration: BoxDecoration(
//                     color: Colors.green[100],
//                     borderRadius: BorderRadius.circular(16), // Rounded corners
//                     image: DecorationImage(
//                       image: _logoImageFile != null
//                           ? FileImage(File(_logoImageFile!.path))
//                           : const AssetImage(AppImages.imagebase)
//                               as ImageProvider,
//                       fit: BoxFit.cover, // Cover the container with the image
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 4,
//                   right: 4,
//                   child: GestureDetector(
//                     onTap: () => _showImageSourceActionSheet(context, 'logo'),
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                       ),
//                       padding: const EdgeInsets.all(6),
//                       child: const Icon(
//                         Icons.camera_alt,
//                         size: 20,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Text("Logo Image"),

//             const SizedBox(height: 20),
//             // Cover Image
//             Stack(
//               alignment: Alignment.bottomRight,
//               children: [
//                 Container(
//                   width: double.infinity, // Set desired width
//                   height: 150, // Set desired height
//                   decoration: BoxDecoration(
//                     color: Colors.green[100],
//                     borderRadius: BorderRadius.circular(
//                         16), // Rounded corners (adjust as needed)
//                     image: DecorationImage(
//                       image: _coverImageFile != null
//                           ? FileImage(File(_coverImageFile!.path))
//                           : const AssetImage(AppImages.imagebase)
//                               as ImageProvider,
//                       fit: BoxFit
//                           .cover, // Ensure the image covers the entire container
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 4,
//                   right: 4,
//                   child: GestureDetector(
//                     onTap: () => _showImageSourceActionSheet(context, 'cover'),
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                       ),
//                       padding: const EdgeInsets.all(6),
//                       child: const Icon(
//                         Icons.camera_alt,
//                         size: 20,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Text("Cover Image"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressTab() {
//     return SingleChildScrollView(
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Form(
//         key: _controller.formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const SizedBox(height: 30),
//             const LabelWithAsterisk(
//               labelText: "Division",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.location_city_rounded,
//               hintText: "Division",
//               controller: _controller.nameController,
//               validator: _controller.validateName,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "District",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.note_add,
//               hintText: "District",
//               controller: _controller.phoneController,
//               keyboardType: TextInputType.phone,
//               validator: _controller.validatePhoneNumber,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "Upazila",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.map,
//               hintText: 'Upazila',
//               controller: _controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: _controller.validateEmail,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "Address Line",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.info,
//               hintText: 'Address Line',
//               controller: _controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: _controller.validateEmail,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "Zip Code",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.maps_ugc_sharp,
//               hintText: 'Zip Code',
//               controller: _controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: _controller.validateEmail,
//             ),
//             const SizedBox(height: 20),
//             const LabelWithAsterisk(
//               labelText: "Phone",
//               isRequired: true,
//             ),
//             CustomTextField(
//               prefixIcon: Icons.phone,
//               hintText: 'Phone',
//               controller: _controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: _controller.validateEmail,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ElevatedButton.icon(
//               onPressed: () {
//                 // Add Save functionality
//               },
//               icon: const Icon(Icons.save),
//               label: const Text("Save"),
//               style: ElevatedButton.styleFrom(
//                 minimumSize:
//                     const Size(double.infinity, 50), // Make button full-width
//                 backgroundColor:
//                     AppColor.primaryColor, // Change this to your desired color
//                 // For text color:
//                 foregroundColor: Colors.white, // Text and icon color
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             )
//           ],
//         ),
//       )
//     ]));
//   }

//   void _showImageSourceActionSheet(BuildContext context, String imageType) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Gallery'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   _pickImage(ImageSource.gallery, imageType);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_camera),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   _pickImage(ImageSource.camera, imageType);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/view/shopsettings/shop_setting_controller.dart';
import 'package:isotopeit_b2b/view/signup/signup_controller.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';

class ShopSettingsPage extends StatefulWidget {
  const ShopSettingsPage({super.key});

  @override
  State<ShopSettingsPage> createState() => _ShopSettingsPageState();
}

class _ShopSettingsPageState extends State<ShopSettingsPage> {

  final ShopSettingController _controller = Get.put(ShopSettingController());
 
  final ImagePicker _picker = ImagePicker();

  XFile? _logoImageFile;
  XFile? _coverImageFile;

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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Shop Settings',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColor.primaryColor.withOpacity(0.7),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          bottom: const TabBar(
            labelColor: Colors.white, // Color for selected tab
            unselectedLabelColor: Colors.grey, // Color for unselected tabs
            indicatorColor: AppColor.primaryColor,
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
              _buildGeneralTab(),
              _buildImageTab(),
              _buildAddressTab(),
            ],
          ),
        ),
        //floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      child: Form(
        
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
              controller: _controller.appNameValidator,
              validator: (value) =>
                  _controller.appValidator.validateName(value),
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Slug",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.note_add,
              hintText: "Slug",
              controller: _controller.appPhoneValidator,
              keyboardType: TextInputType.phone,
              // validator: _controller.validatePhoneNumber,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Full Name (Trade License)",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.people,
              hintText: 'Full Name (Trade License',
              controller: _controller.appEmailValidator,
              keyboardType: TextInputType.emailAddress,
              //validator: _controller.validateEmail,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Trade license no:",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.info,
              hintText: 'Trade license',
              controller: _controller.appEmailValidator,
              keyboardType: TextInputType.emailAddress,
              //validator: _controller.validateEmail,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "Email address:",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.email,
              hintText: 'ak@gmail.com',
              controller: _controller.appEmailValidator,
              keyboardType: TextInputType.emailAddress,
              //validator: _controller.validateEmail,
            ),
            const SizedBox(height: 20),
            const LabelWithAsterisk(
              labelText: "External url:",
              isRequired: true,
            ),
            CustomTextField(
              prefixIcon: Icons.library_add,
              hintText: 'External url',
              controller: _controller.appEmailValidator,
              keyboardType: TextInputType.emailAddress,
              //validator: _controller.validateEmail,
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
              controller: _controller.appEmailValidator,
              keyboardType: TextInputType.emailAddress,
              //validator: _controller.validateEmail,
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
              controller: _controller.appEmailValidator,
              keyboardType: TextInputType.emailAddress,
              //validator: _controller.validateEmail,
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
                Container(
                  width: double.infinity, // Set desired width
                  height: 150, // Set desired height
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                    image: DecorationImage(
                      image: _logoImageFile != null
                          ? FileImage(File(_logoImageFile!.path))
                          : const AssetImage(AppImages.imagebase)
                              as ImageProvider,
                      fit: BoxFit.cover, // Cover the container with the image
                    ),
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
                Container(
                  width: double.infinity, // Set desired width
                  height: 150, // Set desired height
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(
                        16), // Rounded corners (adjust as needed)
                    image: DecorationImage(
                      image: _coverImageFile != null
                          ? FileImage(File(_coverImageFile!.path))
                          : const AssetImage(AppImages.imagebase)
                              as ImageProvider,
                      fit: BoxFit
                          .cover, // Ensure the image covers the entire container
                    ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Division: Dhaka',
                        style: TextStyle(fontSize: 16)),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green.withOpacity(0.2),
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () {
                              // Implement your edit functionality here
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red.withOpacity(0.2),
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Implement your delete functionality here
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Text('District: Gazipur', style: TextStyle(fontSize: 16)),
                const Text('Upazila: Gazipur Sadar',
                    style: TextStyle(fontSize: 16)),
                const Text('Address Line: Monihar market, Dokan 14',
                    style: TextStyle(fontSize: 16)),
                const Text('Zip Code: 1702', style: TextStyle(fontSize: 16)),
                const Text('Phone: 01999023636',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: () {
            _showAddressForm();
          },
          icon: const Icon(Icons.add),
          label: const Text("Create Address"),
          style: ElevatedButton.styleFrom(
            minimumSize:
                const Size(double.infinity, 50), // Make button full-width
            backgroundColor:
                AppColor.primaryColor, // Change this to your desired color
            // For text color:
            foregroundColor: Colors.white, // Text and icon color
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _showAddressForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Form(
              //key: _formKey,
              child: Column(
                children: <Widget>[
                  const LabelWithAsterisk(
                      labelText: "Division", isRequired: true),
                  CustomTextField(
                    prefixIcon: Icons.location_city_rounded,
                    hintText: "Division",
                    controller: _zipController,
                  ),
                  const SizedBox(height: 20),
                  const LabelWithAsterisk(
                      labelText: "District", isRequired: true),
                  CustomTextField(
                    prefixIcon: Icons.location_on,
                    hintText: "District",
                    controller: _zipController,
                  ),
                  const SizedBox(height: 20),
                  const LabelWithAsterisk(
                      labelText: "Upazila", isRequired: true),
                  CustomTextField(
                    prefixIcon: Icons.map,
                    hintText: 'Upazila',
                    controller: _zipController,
                  ),
                  const SizedBox(height: 20),
                  const LabelWithAsterisk(
                      labelText: "Address Line", isRequired: true),
                  CustomTextField(
                    prefixIcon: Icons.home,
                    hintText: 'Address Line',
                    controller: _zipController,
                  ),
                  const SizedBox(height: 20),
                  const LabelWithAsterisk(
                      labelText: "Zip Code", isRequired: true),
                  CustomTextField(
                    prefixIcon: Icons.pin_drop,
                    hintText: 'Zip Code',
                    controller: _zipController,
                  ),
                  const SizedBox(height: 20),
                  const LabelWithAsterisk(labelText: "Phone", isRequired: true),
                  CustomTextField(
                    prefixIcon: Icons.phone,
                    hintText: 'Phone',
                    controller: _zipController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   Navigator.pop(context); // Dismiss form after save
                      // }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Save Address"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
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
                  _pickImage(ImageSource.gallery, imageType);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera, imageType);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
