import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/view/banner/add_banner/add_banner_controller.dart';
import 'package:isotopeit_b2b/view/banner/add_banner/banner_add_model.dart';

class EditBannerBottomSheet extends StatefulWidget {
  final BannerModel banner;

  const EditBannerBottomSheet({Key? key, required this.banner})
      : super(key: key);

  @override
  State<EditBannerBottomSheet> createState() => _EditBannerBottomSheetState();
}

class _EditBannerBottomSheetState extends State<EditBannerBottomSheet> {
  final AddBannerController _controller = Get.put(AddBannerController());
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _controller.titleController.text = widget.banner.title ?? '';
    _controller.descriptionController.text = widget.banner.description ?? '';
    _controller.linkController.text = widget.banner.link ?? '';
    _controller.linkLabelController.text = widget.banner.linkLabel ?? '';
    _controller.bgColorController.text = widget.banner.bgColor ?? '';
    _controller.columnsController.text = widget.banner.columns ?? '';
    _controller.orderController.text = widget.banner.order ?? '';
    _controller.effectController.text =
        widget.banner.effect == true ? 'true' : 'false';
    _controller.setFeatureImagePath(widget.banner.featureImage ?? '');
  }

  // Method to pick image from gallery or camera
  Future<void> _pickImage() async {
    // Show a bottom sheet to select image source
    final pickedSource = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pick from Gallery'),
              onTap: () {
                Navigator.pop(context, ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );

    // If a source is selected, pick the image
    if (pickedSource != null) {
      final XFile? pickedFile = await _picker.pickImage(source: pickedSource);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
          _controller.setFeatureImagePath(pickedFile.path);
        });
      }
    }
  }

  // Method to update the banner
  void _updateBanner() async {
    final success = await _controller.updateBanner(widget.banner.id!);
    if (success) {
      Get.back(); // Close the bottom sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Edit Banner",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 65,
                backgroundColor: Colors.green[100],
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _imageFile != null
                      ? FileImage(File(_imageFile!.path))
                      : (widget.banner.featureImage != null
                          ? NetworkImage(widget.banner.featureImage!)
                              as ImageProvider
                          : const AssetImage('assets/images/placeholder.png')),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller.titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller.descriptionController,
            decoration: const InputDecoration(labelText: "Description"),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller.linkController,
            decoration: const InputDecoration(labelText: "Redirect Link"),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller.linkLabelController,
            decoration: const InputDecoration(labelText: "Link Label"),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller.bgColorController,
            decoration: const InputDecoration(labelText: "Background Color"),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller.columnsController,
            decoration: const InputDecoration(labelText: "Columns"),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller.orderController,
            decoration: const InputDecoration(labelText: "Order"),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller.effectController,
            decoration: const InputDecoration(labelText: "Effect (true/false)"),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: _updateBanner,
              child: const Text("Update Banner"),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
