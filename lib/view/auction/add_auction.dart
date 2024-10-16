import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';

class AddAuction extends StatefulWidget {
  const AddAuction({super.key});

  @override
  State<AddAuction> createState() => _AddAuctionState();
}

class _AddAuctionState extends State<AddAuction> {
  bool isCertified = false;

  // Create a TextEditingController to store the selected date and time
  final TextEditingController _startDateTimeController =
      TextEditingController();
  final TextEditingController _EnddateTimeController = TextEditingController();
  final TextEditingController _availabledateTimeController =
      TextEditingController();

  // Controllers for key features
  final List<TextEditingController> _keyFeatureControllers = [
    TextEditingController()
  ];

  // Tags handling
  final List<String> _availableTags = [
    "Stock Limited",
    "Top Trending",
    "Best Seller",
    "New Arrival"
  ];
  final List<String> _selectedTags = [];

  //product
  String? _selectedProduct;

  final List<String> _productList = [
    "Product 1",
    "Product 2",
    "Product 3",
    "Product 4",
    "Product 5",
    // Add more products as needed
  ];

  // DateTime? selectedDateTime;

  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;
  DateTime? selectedAvailableDateTime;

  final _formKey = GlobalKey<FormState>();
  // GlobalKey for form validation
  final TextEditingController _zipController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imageFiles = []; // Holds up to 5 images

  // Image picking logic for gallery (allow multiple) and camera (single)
  Future<void> _pickImage(ImageSource source, {bool multiple = false}) async {
    if (multiple) {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      setState(() {
        // Add new images if the limit of 5 is not exceeded
        _imageFiles.addAll(pickedFiles.take(5 - _imageFiles.length));
      });
    } else {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          if (_imageFiles.length < 5) {
            _imageFiles.add(pickedFile);
          }
        });
      }
    }
  }

  // Function to remove an image
  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  @override
  void dispose() {
    _startDateTimeController.dispose();
    _EnddateTimeController.dispose();
    _availabledateTimeController
        .dispose(); // Dispose controller when widget is destroyed
    for (var controller in _keyFeatureControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Auction",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column

                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),

                          const LabelWithAsterisk(
                            labelText: "Auction Images (Max 5)",
                            isRequired: true,
                          ),
                          const SizedBox(height: 20),

                          _buildImagePicker(),

                          const SizedBox(
                            height: 10,
                          ),
                          const LabelWithAsterisk(
                            labelText: "Product",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Product Name"),

                          const LabelWithAsterisk(
                            labelText: "SKU",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Seller SKU"),
                          const LabelWithAsterisk(
                            labelText: "Status",
                            isRequired: true,
                          ),
                          _buildDropdown("Status", ["Active", "Inactive"]),
                          // _buildCheckbox("BSTI Certification"),
                          const LabelWithAsterisk(
                            labelText: "Key features",
                          ),
                          //_buildTextField("Enter Key Features"),

                          ..._buildKeyFeatureFields(),

                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: _addKeyFeature,
                              icon: const Icon(Icons.add),
                              label: const Text("Add Key Feature"),
                            ),
                          ),
                          const SizedBox(height: 10),

                          const SizedBox(height: 10),
                          const LabelWithAsterisk(
                            labelText: "Base Price",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Price"),
                          const LabelWithAsterisk(
                            labelText: "Stock Quantity",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Stock Quantity"),

                          const LabelWithAsterisk(
                            labelText: "Meta Description",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Meta Description",
                              maxLines: 3),

                          const Text(
                            "Additional Info",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const LabelWithAsterisk(
                            labelText: "Enter Tags",
                          ),
                          //_buildTextField("Enter Tags"),

                          // Dropdown for selecting tags
                          _buildTagDropdown(),

                          // Display selected tags as chips
                          _buildTagChips(),

                          const Text(
                            "Auction Info",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const LabelWithAsterisk(
                            labelText: "Auction Date",
                          ),
                          // _buildDatePicker("Offer End Date"),

                          _buildDatePicker("Date", _startDateTimeController,
                              (DateTime? selectedDate) {
                            setState(() {
                              selectedStartDateTime = selectedDate;
                            });
                          }),

                          const LabelWithAsterisk(
                            labelText: "Registration Last Date",
                          ),
                          _buildDatePicker("Date", _EnddateTimeController,
                              (DateTime? selectedDate) {
                            setState(() {
                              selectedEndDateTime = selectedDate;
                            });
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),
                  ],
                ),
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
      ),
    );
  }

  // Image picker widget showing selected images and option to add more
  Widget _buildImagePicker() {
    return Column(
      children: [
        if (_imageFiles.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _imageFiles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.file(
                    File(_imageFiles[index].path),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        color: Colors.black54,
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        const SizedBox(
          height: 10,
        ),
        if (_imageFiles.length < 5)
          ElevatedButton.icon(
            onPressed: () {
              _showImageSourceActionSheet(context);
            },
            icon: const Icon(Icons.add_a_photo),
            label: const Text("Add Images (Max 5)"),
          ),
      ],
    );
  }

  // Show action sheet to choose between camera and gallery
  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery (Multiple)'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery, multiple: true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera (Single)'),
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

  // Function to build dropdown for selecting tags
  Widget _buildTagDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Select a tag",
      ),
      items: _availableTags.map((String tag) {
        return DropdownMenuItem<String>(
          value: tag,
          child: Text(tag),
        );
      }).toList(),
      onChanged: (String? selectedTag) {
        if (selectedTag != null && !_selectedTags.contains(selectedTag)) {
          setState(() {
            _selectedTags.add(selectedTag);
          });
        }
      },
    );
  }

  // Function to display selected tags as chips
  Widget _buildTagChips() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Wrap(
        spacing: 8.0,
        children: _selectedTags.map((String tag) {
          return Chip(
            label: Text(tag),
            backgroundColor: Colors.green.withOpacity(0.2),
            deleteIcon: const Icon(Icons.close),
            onDeleted: () {
              setState(() {
                _selectedTags.remove(tag);
              });
            },
          );
        }).toList(),
      ),
    );
  }

  // Function to build dynamic key feature fields
  List<Widget> _buildKeyFeatureFields() {
    return _keyFeatureControllers.asMap().entries.map((entry) {
      int index = entry.key;
      TextEditingController controller = entry.value;

      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Enter Key Feature ${index + 1}",
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.red.withOpacity(0.2),
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeKeyFeature(index),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  // Add a new key feature field
  void _addKeyFeature() {
    setState(() {
      _keyFeatureControllers.add(TextEditingController());
    });
  }

  // Remove a specific key feature field
  void _removeKeyFeature(int index) {
    if (_keyFeatureControllers.length > 1) {
      setState(() {
        _keyFeatureControllers[index].dispose();
        _keyFeatureControllers.removeAt(index);
      });
    }
  }

  // Function to build text fields
  Widget _buildTextField(String hint, {String? label, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        maxLines: maxLines,
      ),
    );
  }

  // Function to build dropdown fields
  Widget _buildDropdown(String? hintText, List<String> options) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {},
      ),
    );
  }

  // Function to build checkbox
  Widget _buildCheckbox(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Checkbox(
            value: isCertified,
            onChanged: (bool? value) {
              setState(() {
                isCertified = value ?? false; // Toggle checkbox state
              });
            },
          ),
          Text(label),
        ],
      ),
    );
  }

  // Function to build date picker fields
  Widget _buildDatePicker(String hintText, TextEditingController controller,
      Function(DateTime?) onDateSelected) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller, // Set the appropriate controller here
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: const Icon(Icons.calendar_today),
          border: const OutlineInputBorder(),
        ),
        readOnly: true, // Makes the field non-editable
        onTap: () async {
          FocusScope.of(context)
              .requestFocus(FocusNode()); // Dismiss the keyboard

          // Show date picker dialog
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000), // Earliest date
            lastDate: DateTime(2100), // Latest date
          );

          if (pickedDate != null) {
            // Show time picker dialog if a date was picked
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (pickedTime != null) {
              setState(() {
                DateTime selectedDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );

                // Update the controller text with the selected date and time
                controller.text =
                    "${selectedDateTime.day}-${selectedDateTime.month}-${selectedDateTime.year} ${_formatTime(selectedDateTime)}";

                // Callback to notify the selected date
                onDateSelected(selectedDateTime);
              });
            }
          }
        },
      ),
    );
  }

  // Helper function to format time as AM/PM
  String _formatTime(DateTime dateTime) {
    final timeOfDay = TimeOfDay.fromDateTime(dateTime);
    final hour = timeOfDay.hourOfPeriod == 0
        ? 12
        : timeOfDay.hourOfPeriod; // Convert hour to 12-hour format
    final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    final minute = timeOfDay.minute
        .toString()
        .padLeft(2, '0'); // Ensure minute is always two digits
    return '$hour:$minute $period';
  }
}

// Function to build file picker fields
Widget _buildFilePicker(String label, String buttonText) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // File picker logic here
          },
          child: Text(buttonText),
        ),
      ],
    ),
  );
}
