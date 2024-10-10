import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BannerItem {
  String title;
  String imageUrl;

  BannerItem({required this.title, required this.imageUrl});
}

class BannerManager extends StatefulWidget {
  @override
  _BannerManagerState createState() => _BannerManagerState();
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
                    child: Text('Pick from Camera'),
                  ),
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.gallery),
                    child: Text('Pick from Gallery'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Title Field
              TextField(
                controller: titleController,
                decoration: InputDecoration(
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
                      SnackBar(content: Text('Please enter valid details')),
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
        title: Text('Banner Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: banners.length,
          itemBuilder: (context, index) {
            final banner = banners[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: FileImage(File(banner.imageUrl)),
                  backgroundColor: Colors.grey[300],
                ),
                title: Text(banner.title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.2),
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () =>
                            showBannerModal(banner: banner, index: index),
                      ),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: Colors.red.withOpacity(0.2),
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteBanner(index),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBannerModal(),
        child: Icon(Icons.add),
        tooltip: 'Add Banner',
      ),
    );
  }
}
