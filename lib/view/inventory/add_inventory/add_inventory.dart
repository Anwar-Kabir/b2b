import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/product/productlist/controller_product_list.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';
import 'package:http/http.dart' as http;

class AddInventoryPage extends StatefulWidget {
  const AddInventoryPage({super.key});

  @override
  State<AddInventoryPage> createState() => _AddInventoryPageState();
}

class _AddInventoryPageState extends State<AddInventoryPage> {
  bool isCertified = false;

 
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _startDateTimeController =
      TextEditingController();
  final TextEditingController _enddateTimeController = TextEditingController();
  final TextEditingController _availabledateTimeController =
      TextEditingController();
  //final _formKey = GlobalKey<FormState>();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _offerController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _packingQuantity = TextEditingController();
  final TextEditingController _metaDescriptionController =
      TextEditingController();
  final List<TextEditingController> _keyFeatureControllers = [
    TextEditingController()
  ];
  final TextEditingController _disController = TextEditingController();
  final TextEditingController _metaTitleController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _netAmmountController = TextEditingController();
  final TextEditingController _commissionController = TextEditingController();

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

  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;
  DateTime? selectedAvailableDateTime;

  //status
  String? selectedStatus; // To store the selected status as a string
  int? selectedStatusValue; // To store the corresponding numeric value

  // Add a variable to track the checkbox state

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
    _enddateTimeController.dispose();
    _availabledateTimeController
        .dispose(); // Dispose controller when widget is destroyed
    for (var controller in _keyFeatureControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Inventory",
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
            key: _formKey,
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
                            labelText: "Product Images (Max 5)",
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
                          // _buildTextField("Enter Product Name"),
                          Obx(() {
                            if (productController.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (productController.productList.isEmpty) {
                              return const Text(
                                "No products available.",
                                style: TextStyle(color: Colors.red),
                              );
                            }
                            return DropdownButtonFormField<String>(
                              value: _selectedProduct, // Selected product
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                              ),
                              hint: const Text("Select a product"),
                              items:
                                  productController.productList.map((product) {
                                return DropdownMenuItem<String>(
                                  value: product.id
                                      .toString(), // Assuming `id` is String or can be converted
                                  child:
                                      Text(product.name ?? "Unnamed Product"),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedProduct =
                                      value; // Update selected product
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select a product";
                                }
                                return null;
                              },
                            );
                          }),

                          const LabelWithAsterisk(
                            labelText: "SKU",
                            isRequired: true,
                          ),
                          //_buildTextField("Enter Seller SKU"),
                          _buildTextField("Enter Seller SKU",
                              controller: _skuController, isRequired: true),
                          const LabelWithAsterisk(
                            labelText: "Status",
                            isRequired: true,
                          ),

                          _buildDropdown("Status", ["Active", "Inactive"]),

                          //bsti_certification
                          _buildCheckbox("BSTI Certification"),

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

                          const LabelWithAsterisk(
                            labelText: "Price",
                            isRequired: true,
                          ),

                          _buildTextField("Enter Price",
                              isRequired: true, controller: _priceController),
                          const LabelWithAsterisk(
                            labelText: "Offer",
                          ),
                          _buildTextField("Enter Offer Price",
                              isRequired: true, controller: _offerController),
                          const LabelWithAsterisk(
                            labelText: "Stock Quantity",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Stock Quantity",
                              isRequired: true,
                              controller: _quantityController),
                          const LabelWithAsterisk(
                            labelText: "Packing Quantity",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Packing Quantity",
                              isRequired: true, controller: _packingQuantity),

                          //date
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

                          //end date
                          const LabelWithAsterisk(
                            labelText: "Offer End Date",
                          ),
                          _buildDatePicker(
                              "Offer End Date", _enddateTimeController,
                              (DateTime? selectedDate) {
                            setState(() {
                              selectedEndDateTime = selectedDate;
                            });
                          }),

                          //description
                          const LabelWithAsterisk(
                            labelText: "Description",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Description",
                              maxLines: 4,
                              isRequired: true,
                              controller: _disController),
                          // _buildFilePicker("Images", "Choose Files"),

                          ///Available
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

                          //tag
                          const LabelWithAsterisk(
                            labelText: "Enter Tags",
                          ),
                          //_buildTextField("Enter Tags"),

                          // Dropdown for selecting tags
                          _buildTagDropdown(),

                          // Display selected tags as chips
                          _buildTagChips(),

                          ///commission
                          const LabelWithAsterisk(
                            labelText: "Enter Commission in (%)",
                          ),
                          _buildTextField("9,",
                              isRequired: true,
                              controller: _commissionController),
                          const LabelWithAsterisk(
                            labelText: "Enter Net Amount",
                          ),
                          _buildTextField("0.00",
                              isRequired: true,
                              controller: _netAmmountController),

                          const LabelWithAsterisk(
                            labelText: "Purchase Price",
                          ),
                          _buildTextField("Meta Title",
                              isRequired: true,
                              controller: _purchasePriceController),
                          const LabelWithAsterisk(
                            labelText: "Meta Title",
                          ),
                          _buildTextField("Enter Meta Title",
                              isRequired: true,
                              controller: _metaTitleController),
                          const LabelWithAsterisk(
                            labelText: "Meta Description",
                            isRequired: true,
                          ),
                          _buildTextField("Enter Meta Description",
                              maxLines: 3,
                              isRequired: true,
                              controller: _metaDescriptionController),
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
          onPressed: () async {
            ///print the data====>
            if (_formKey.currentState?.validate() ?? false) {
              if (_imageFiles.isEmpty) {
                print("No images selected.");
              } else {
                for (int i = 0; i < _imageFiles.length; i++) {
                  print("Image ${i + 1}: ${_imageFiles[i].name}");
                  print("Path: ${_imageFiles[i].path}");
                }
              }
              print(" product ===========>  $_selectedProduct)}");

              print(" sku============= $_skuController)}");

              if (selectedStatus != null) {
                print("Selected Status: $selectedStatusValue");
              } else {
                print("No status selected");
              }

              print(
                  " keyFeatureControllers ===========>  $_keyFeatureControllers)}");

              print("price   $_priceController)}");
              print("offer   $_offerController)}");
              print("discription ::===>   $_disController)}");

              print(" quantity $_quantityController)}");
              print(" package quantity $_packingQuantity)}");
              print(" commission $_commissionController)}");
              print(" net amout $_netAmmountController)}");
              print(" purchage price $_purchasePriceController)}");
              print(" mete $_metaTitleController)}");

              print(" metaDescription $_metaDescriptionController)}");

              print(" tag ===========>  $_selectedTags)}");

              print(isCertified ? "btis ===> Selected: true" : "bits ===> Unselected: false");

              if (selectedStartDateTime != null) {
                print(
                    "Selected Start Date: ${selectedStartDateTime!.toIso8601String()}");
              } else {
                print("No date selected");
              }

              if (selectedEndDateTime != null) {
                print(
                    "Selected end Date: ${selectedEndDateTime!.toIso8601String()}");
              } else {
                print("No date selected");
              }

              if (selectedAvailableDateTime != null) {
                print(
                    "Selected vailable Date: ${selectedAvailableDateTime!.toIso8601String()}");
              } else {
                print("No date selected");
              }

              // Collect form data
              final formData = {
                "product_id":
                    _selectedProduct, // Replace with actual product ID
                "sku": _skuController.text,
                "active": selectedStatus == "Active" ? 1 : 2,
                'bsti_certification': isCertified,
                'stock_quantity' : _quantityController,
                'sale_price' : _priceController, 
                'offer_price': _offerController,
                'packing_qty' : _packingQuantity,
                
                "key_features":
                    _keyFeatureControllers.map((c) => c.text).toList(),
                "description": _disController.text,
                "tag_list": _selectedTags,
                "offer_start": selectedStartDateTime?.toIso8601String(),
                "offer_end":
                    selectedEndDateTime?.toIso8601String(),
                "available_from": selectedAvailableDateTime?.toIso8601String(),
                "purchase_price": _purchasePriceController,
                "meta_title": _metaTitleController,
                "meta_description": _metaDescriptionController,
                "net_amount" : _netAmmountController,
                "attribute[3]": 4,
                
                //'shop_id': 4,
               
              };

              // Convert images to multipart files
              var request = http.MultipartRequest(
                'POST',
                //https://e-commerce.isotopeit.com/api/auctions
                Uri.parse(
                    'https://e-commerce.isotopeit.com/api/inventory/store'),
              );

              // Add form fields
              formData.forEach((key, value) {
                if (value != null) {
                  if (value is List) {
                    for (var item in value) {
                      request.fields['$key[]'] = item.toString();
                    }
                  } else {
                    request.fields[key] = value.toString();
                  }
                }
              });

              // Add images to the request
              for (int i = 0; i < _imageFiles.length; i++) {
                final imageFile = File(_imageFiles[i].path);
                request.files.add(await http.MultipartFile.fromPath(
                  'bluck_image[]',
                  imageFile.path,
                ));
              }

              final TokenService _tokenService = TokenService();

              // Add headers
              request.headers.addAll({
                'Authorization': 'Bearer ${_tokenService.token}',
                'Content-Type': 'multipart/form-data',
              });

              try {
                // Send the request
                var response = await request.send();

                // Handle the response
                if (response.statusCode == 200) {
                  // Parse the response
                  var responseBody = await response.stream.bytesToString();
                  print("API Call Successful: $responseBody");
                } else {
                  // Print the error details
                  var errorResponse = await response.stream.bytesToString();
                  print("API Call Failed: ${response.statusCode}");
                  print("Error Response: $errorResponse");
                }
              } catch (e) {
                // Catch and print any errors
                print("API Call Error: $e");
              }
            } else {
              // Form is invalid, show error
              print("Form is invalid. Please check the inputs.");
            }
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
  Widget _buildTextField(
    String hint, {
    String? label,
    int maxLines = 1,
    TextEditingController? controller,
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        maxLines: maxLines,
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return '$required';
                }
                return null;
              }
            : null,
      ),
    );
  }



  Widget _buildDropdown(String? hintText, List<String> options) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        value: selectedStatus, // Set the current selected value
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedStatus = newValue; // Update the selected value
            // Map status to numeric value
            if (selectedStatus == "Active") {
              selectedStatusValue = 1;
            } else if (selectedStatus == "Inactive") {
              selectedStatusValue = 2;
            }
            print("Selected Status: $selectedStatus ($selectedStatusValue)");
          });
        },
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
