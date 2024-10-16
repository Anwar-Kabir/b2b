import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/banner/add_banner.dart';
import 'package:isotopeit_b2b/view/banner/banner_details.dart';

class BannerItem {
  BannerItem({
    required this.title,
    required this.imageUrl,
  });
  String title;
  String imageUrl;
}

class BannerManager extends StatefulWidget {
  const BannerManager({super.key});

  @override
  State<BannerManager> createState() => _BannerManagerState();
}

class _BannerManagerState extends State<BannerManager> {
  List<BannerItem> banners = [];
  final ImagePicker _picker = ImagePicker();
  final String defaultImageUrl =
      'https://via.placeholder.com/150'; // URL for the default image

  // Show modal to add/edit banner
  void showBannerModal({BannerItem? banner, int? index}) async {
    final TextEditingController titleController =
        TextEditingController(text: banner?.title ?? '');
    String? selectedImageUrl =
        banner?.imageUrl ?? defaultImageUrl; // Default image URL initially

    void pickImage(ImageSource source) async {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          selectedImageUrl =
              pickedFile.path; // Replace default with selected image
        });
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display selected image or default placeholder
              Column(
                children: [
                  selectedImageUrl!.startsWith('http')
                      ? Image.network(
                          selectedImageUrl!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(selectedImageUrl!),
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                  const SizedBox(height: 10),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.camera),
                    child: const Text('Pick from Camera'),
                  ),
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.gallery),
                    child: const Text('Pick from Gallery'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Title Field
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Banner Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String newTitle = titleController.text;
                  if (newTitle.isNotEmpty && selectedImageUrl != null) {
                    setState(() {
                      if (index != null) {
                        // Update the existing banner
                        banners[index] = BannerItem(
                          title: newTitle,
                          imageUrl: selectedImageUrl!,
                        );
                      } else {
                        // Add new banner
                        banners.add(BannerItem(
                          title: newTitle,
                          imageUrl: selectedImageUrl!,
                        ));
                      }
                    });
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter valid details')),
                    );
                  }
                },
                child: Text(index != null ? 'Update Banner' : 'Add Banner'),
              ),
              const SizedBox(height: 10),
              // Delete Button
            ],
          ),
        );
      },
    );
  }

  // Delete banner
  void deleteBanner(int index) {
    setState(() {
      banners.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Banners",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const AddBanner(),
                  transition: Transition.rightToLeftWithFade);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Get.to(const BannerDetails(),
                transition: Transition.rightToLeftWithFade);
          },
          child: SizedBox(
            height: 115,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aligns items to the top
                  children: <Widget>[
                    // Image on the left (leading)
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Rounded image corners
                        image: const DecorationImage(
                          image:
                              AssetImage('assets/abc.jpg'), // Local asset image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Space between image and text
                    const SizedBox(width: 12),

                    // Product details
                    const Expanded(
                      // Makes sure text occupies the remaining space
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Product name
                          Text(
                            "Suscipit aut sunt qu",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            'Columns: 4, Serial Number: 100',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),

                          Text('Link label: , Link: '),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
