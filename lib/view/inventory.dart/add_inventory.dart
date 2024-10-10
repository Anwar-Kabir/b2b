import 'dart:io';

 
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';


class AddInventoryPage extends StatefulWidget {
  @override
  _AddInventoryPageState createState() => _AddInventoryPageState();
}

class _AddInventoryPageState extends State<AddInventoryPage> {
  bool isCertified = false;

  // Create a TextEditingController to store the selected date and time
  final TextEditingController _startDateTimeController =
      TextEditingController();
  final TextEditingController _EnddateTimeController = TextEditingController();
  final TextEditingController _availabledateTimeController =
      TextEditingController();

  // Controllers for key features
  List<TextEditingController> _keyFeatureControllers = [
    TextEditingController()
  ];

 // Tags handling
  List<String> _availableTags = [
    "Stock Limited",
    "Top Trending",
    "Best Seller",
    "New Arrival"
  ];
  List<String> _selectedTags = [];
  

  //product
   String? _selectedProduct;

  List<String> _productList = [
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
  void dispose() {
    _startDateTimeController.dispose();
    _EnddateTimeController.dispose();
    _availabledateTimeController
        .dispose(); // Dispose controller when widget is destroyed
     _keyFeatureControllers.forEach((controller) => controller.dispose());    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Inventory"),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              // Add Save Functionality
            },
            icon: Icon(Icons.save),
            label: Text("Save"),
          ),
          SizedBox(
            width: 5,
          )
        ],
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

                          SizedBox(
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
                          _buildCheckbox("BSTI Certification"),
                          const LabelWithAsterisk(
                            labelText: "Key features",
                          ),
                          //_buildTextField("Enter Key Features"),

                           ..._buildKeyFeatureFields(),

                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: _addKeyFeature,
                              icon: Icon(Icons.add),
                              label: Text("Add Key Feature"),
                            ),
                          ),
                          SizedBox(height: 10),


                          const LabelWithAsterisk(
                            labelText: "Price",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Price"),
                          const LabelWithAsterisk(
                            labelText: "Offer",
                          ),
                          _buildTextField("Enter Offer Price"),
                          const LabelWithAsterisk(
                            labelText: "Stock Quantity",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Stock Quantity"),
                          const LabelWithAsterisk(
                            labelText: "Packing Quantity",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Packing Quantity"),
                          const LabelWithAsterisk(
                            labelText: "Offer Start Date",
                          ),
                          // _buildDatePicker("Offer End Date"),

                          _buildDatePicker(
                              "Offer Start Date", _startDateTimeController,
                              (DateTime? selectedDate) {
                            setState(() {
                              selectedStartDateTime = selectedDate;
                            });
                          }),

                          const LabelWithAsterisk(
                            labelText: "Offer End Date",
                          ),
                          _buildDatePicker(
                              "Offer End Date", _EnddateTimeController,
                              (DateTime? selectedDate) {
                            setState(() {
                              selectedEndDateTime = selectedDate;
                            });
                          }),

                          const LabelWithAsterisk(
                            labelText: "Description",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Description", maxLines: 4),
                          // _buildFilePicker("Images", "Choose Files"),
                          const LabelWithAsterisk(
                            labelText: "Available From",
                          ),
                          _buildDatePicker(
                              "Available From", _availabledateTimeController,
                              (DateTime? selectedDate) {
                            setState(() {
                              selectedAvailableDateTime = selectedDate;
                            });
                          }),
                          const LabelWithAsterisk(
                            labelText: "Enter Tags",
                          ),
                          //_buildTextField("Enter Tags"),

                          
                        // Dropdown for selecting tags
                          _buildTagDropdown(),

                          // Display selected tags as chips
                          _buildTagChips(),



                          const LabelWithAsterisk(
                            labelText: "Enter Commission in (%)",
                          ),
                          _buildTextField("9"),
                          const LabelWithAsterisk(
                            labelText: "Enter Net Amount",
                          ),
                          _buildTextField("0.00"),

                          const LabelWithAsterisk(
                            labelText: "Purchase Price",
                          ),
                          _buildTextField("Meta Title"),
                          const LabelWithAsterisk(
                            labelText: "Meta Title",
                          ),
                          _buildTextField("Enter Meta Title"),
                          const LabelWithAsterisk(
                            labelText: "Meta Description",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Meta Description",
                              maxLines: 3),
                        ],
                      ),
                    ),

                    SizedBox(width: 16),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

     
  // Function to build dropdown for selecting tags
  Widget _buildTagDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
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
            deleteIcon: Icon(Icons.close),
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
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeKeyFeature(index),
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
          border: OutlineInputBorder(),
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
          border: OutlineInputBorder(),
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
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(),
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

// Function to build file picker fields
Widget _buildFilePicker(String label, String buttonText) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
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
