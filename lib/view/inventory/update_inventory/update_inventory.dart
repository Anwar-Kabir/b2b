import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/url.dart';
import 'package:isotopeit_b2b/view/category&tag/tag/controller_tag.dart';
import 'package:isotopeit_b2b/view/inventory/add_inventory/attribute/attribute_inventory_controller.dart';
import 'package:isotopeit_b2b/view/inventory/inventory_details/inventory_details_controller.dart';
import 'package:isotopeit_b2b/view/inventory/inventory_details/inventory_product_details_model.dart';
import 'package:isotopeit_b2b/view/inventory/inventrory/inventory.dart';
import 'package:isotopeit_b2b/view/inventory/inventrory/inventory_controller.dart';
import 'package:isotopeit_b2b/view/product/productlist/controller_product_list.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';
import 'package:http/http.dart' as http;

class UpdateInventory extends StatefulWidget {
  final int? productID;
  final String? productName;
  final int? inventoryid;
  const UpdateInventory(
      {super.key, this.productID, this.inventoryid, this.productName});

  @override
  State<UpdateInventory> createState() => _AddInventoryPageState();
}

class _AddInventoryPageState extends State<UpdateInventory> {
  final _formKey = GlobalKey<FormState>();

  
  //final _formKey = GlobalKey<FormState>();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  //stock quantity
  final TextEditingController _quantityController = TextEditingController();
  //packing qut
  final TextEditingController _packingQuantity = TextEditingController();
  final List<TextEditingController> _keyFeatureControllers = [
    TextEditingController()
  ];
  final TextEditingController _disController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _netAmmountController = TextEditingController();
  final TextEditingController _calcNetPrice = TextEditingController(text: '0');

  final List<String> _selectedTags = [];

  //product
  String _selectedProduct = 'Select a Product';
  String _selectedProductId = '';

  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;

  final TextEditingController _availabledateTimeController =
      TextEditingController();
  DateTime? selectedAvailableDateTime;

  // //status
  // String? selectedStatus; // To store the selected status as a string
  // int? selectedStatusValue; // To store the corresponding numeric value

  String? selectedStatus = "Active";
  int selectedStatusValue = 1; //

  // Add a variable to track the checkbox state

  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imageFiles = [];

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
    _availabledateTimeController
        .dispose(); // Dispose controller when widget is destroyed
    for (var controller in _keyFeatureControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  final ProductController productController = Get.put(ProductController());
  final AttributeController attributeController =
      Get.put(AttributeController());
  final InventoryDetailController controller =
      Get.put(InventoryDetailController());
  final TagController tagController = Get.put(TagController());

  // @override
  // void initState() {
  //   Future.delayed(Duration(microseconds: 200), () {
  //     controller.fetchInventoryDetail(widget.productID!);

  //     setState(() {
  //       _selectedProductId = widget.productID.toString();
  //       _selectedProduct = widget.productName.toString();

  //       debugPrint(_selectedProduct.toString());
  //       debugPrint(_selectedProductId.toString());
  //     });
  //   });

  //   super.initState();
  // }

  @override
  void initState() {
    super.initState();

    // Fetch inventory details and attributes after widget initialization
    Future.delayed(Duration(milliseconds: 200), () {
      controller.fetchInventoryDetail(widget.productID!);
      setState(() {
        _selectedProductId = widget.productID.toString();
        _selectedProduct = widget.productName.toString();
        debugPrint(_selectedProduct.toString());
        debugPrint(_selectedProductId.toString());
      });

      // Fetch attributes for the product
      attributeController.fetchAttributes(widget.productID!);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Inventory",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value == false) {
            Future.delayed(Duration(microseconds: 200), () {
              _skuController.text = controller.inventoryDetail.value!.sku;
              _priceController.text =
                  controller.inventoryDetail.value!.salePrice.toString();

              _purchasePriceController.text = double.parse(
                controller.inventoryDetail.value!.purchaseprice.toString(),
              ).toStringAsFixed(1);
              _quantityController.text =
                  controller.inventoryDetail.value!.stockQuantity.toString();
              _packingQuantity.text =
                  controller.inventoryDetail.value!.packing_qty.toString();
              _disController.text =
                  controller.inventoryDetail.value!.description.toString();

              _availabledateTimeController.text = DateFormat("MMMM d, yyyy")
                  .format(DateTime.parse(controller
                      .inventoryDetail.value!.availabledateTime
                      .toString()));
              ;
            });
          }
          return controller.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
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

                                    _buildImagePicker(controller
                                        .inventoryDetail.value!.images),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const LabelWithAsterisk(
                                      labelText: "Product",
                                      isRequired: true,
                                    ),


                                   

                                    Obx(() {
                                      if (productController.isLoading.value) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (productController
                                          .productList.isEmpty) {
                                        return const Text(
                                          "No products available.",
                                          style: TextStyle(color: Colors.red),
                                        );
                                      }

                                      return Container(
                                        height: 43,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Colors
                                                .grey,  
                                            width: 1, 
                                          ),
                                          //color: Colors.white,
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(_selectedProduct,
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                            iconEnabledColor: Colors.grey,
                                            iconDisabledColor: Colors.grey,
                                            isExpanded: true,
                                            items: productController.productList
                                                .map((items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items.name.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedProduct =
                                                    value!.name.toString();
                                                _selectedProductId =
                                                    value.id.toString();
                                                // Clear previously selected attributes when product changes
                                                attributeController
                                                    .selectedAttr!
                                                    .clear();
                                              });

                                              debugPrint(
                                                  _selectedProduct.toString());
                                              debugPrint(_selectedProductId
                                                  .toString());

                                              // Fetch attributes for the newly selected product
                                              attributeController
                                                  .fetchAttributes(value!.id);
                                            },
                                          ),
                                        ),
                                      );
                                    }),



                                 

                                    // Attributes Section
                                    Obx(() {
                                      if (attributeController.isLoading.value) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (attributeController
                                          .attributes.isEmpty) {
                                        return const Center(
                                          child: Text("No attributes found."),
                                        );
                                      }

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: attributeController
                                            .attributes.length,
                                        itemBuilder: (context, attributeIndex) {
                                          final attribute = attributeController
                                              .attributes[attributeIndex];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  attribute.name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                DropdownButtonFormField<String>(
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText:
                                                        'Select ${attribute.name}',
                                                  ),
                                                  items: List.generate(
                                                    attribute.values.length,
                                                    (valueIndex) {
                                                      final attvalue = attribute
                                                          .values[valueIndex];
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: "${attvalue.id}",
                                                        child:
                                                            Text(attvalue.text),
                                                      );
                                                    },
                                                  ),
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      Map<String, dynamic>?
                                                          oldAttr =
                                                          attributeController
                                                              .selectedAttr;
                                                      oldAttr![attribute.id
                                                          .toString()] = value;
                                                      attributeController
                                                              .selectedAttr =
                                                          oldAttr;
                                                    }
                                                  },
                                                ),
                                                const SizedBox(height: 16),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }),

                                    ///attribute

                                   

                                    const LabelWithAsterisk(
                                      labelText: "SKU",
                                    ),
                                    //_buildTextField("Enter Seller SKU"),
                                    _buildTextField(
                                      "Enter Seller SKU",
                                      controller: _skuController,
                                    ),
                                    const LabelWithAsterisk(
                                      labelText: "Status",
                                      isRequired: true,
                                    ),

                                    _buildDropdown(
                                        "Status", ["Active", "Inactive"]),

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
                                    SizedBox(
                                      height: 40,
                                      child: TextFormField(
                                        controller: _priceController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '$required';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                        ),
                                        onChanged: (value) {
                                          final commission = attributeController
                                              .commission.value;
                                          final calc = double.parse("$value") +
                                              double.parse("$value") /
                                                  double.parse("$commission");
                                          _calcNetPrice.text = "$calc";
                                          //  _calcNetPrice
                                        },
                                      ),
                                    ),
                                    const Text(
                                      'Commission (%)',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Obx(() {
                                      return SizedBox(
                                        height: 40,
                                        child: TextFormField(
                                          readOnly: true,
                                          controller: TextEditingController(
                                            text:
                                                "${attributeController.commission.value}",
                                          ),
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 12,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    const LabelWithAsterisk(
                                      labelText: "Net Amount",
                                    ),
                                    _buildTextField(
                                      "0.00",
                                      readOnly: true,
                                      isRequired: true,
                                      controller: _calcNetPrice,
                                    ),

                                    const LabelWithAsterisk(
                                      labelText: "Purchase Price",
                                    ),
                                    _buildTextField("Purchase Price",
                                        isRequired: true,
                                        controller: _purchasePriceController),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'MOQ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Obx(() {
                                                return SizedBox(
                                                  height: 40,
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    controller:
                                                        TextEditingController(
                                                            text:
                                                                attributeController
                                                                    .moq.value),
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8,
                                                              horizontal: 12),
                                                    ),
                                                  ),
                                                );
                                              })
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 2.h),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'UOM',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Obx(() {
                                                return SizedBox(
                                                  height: 40,
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    controller:
                                                        TextEditingController(
                                                            text:
                                                                attributeController
                                                                    .uom.value),
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8,
                                                              horizontal: 12),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    //stock quantity
                                    SizedBox(height: 10.h),
                                    const LabelWithAsterisk(
                                      labelText: "Stock Quantity",
                                      isRequired: true,
                                    ),
                                    _buildTextField("Enter Stock Quantity",
                                        isRequired: true,
                                        controller: _quantityController),

                                    //packing quantity
                                    const LabelWithAsterisk(
                                      labelText: "Packing Quantity",
                                      isRequired: true,
                                    ),
                                    _buildTextField("Enter Packing Quantity",
                                        isRequired: true,
                                        controller: _packingQuantity),

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

                                    //Available
                                    const LabelWithAsterisk(
                                      labelText: "Available From",
                                    ),
                                    _buildDatePicker("Available From",
                                        _availabledateTimeController,
                                        (DateTime? selectedDate) {
                                      setState(() {
                                        selectedAvailableDateTime =
                                            selectedDate;
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
                );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          return ElevatedButton.icon(
            onPressed: attributeController.commission.value.length < 1
                ? null
                : () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_imageFiles.isEmpty) {
                        Get.snackbar(
                          "Error",
                          'No images selected',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      final TokenService _tokenService = TokenService();
                      print('Token: ${_tokenService.token}');

                      Map<String, dynamic> arr = {};

                      for (var attr
                          in attributeController.selectedAttr!.entries) {
                        arr[attr.key] = attr.value;
                      }

                      final formData = {
                        "product_id": _selectedProductId,
                        "sku": _skuController.text,
                        "active": selectedStatus == "Active" ? true : false,
                        'stock_quantity': _quantityController.text,
                        'sale_price': _priceController.text,
                        'packing_qty': _packingQuantity.text,
                        "key_features":
                            _keyFeatureControllers.map((c) => c.text).toList(),
                        "description": _disController.text,
                        "tag_list": _selectedTags,
                        "available_from":
                            selectedAvailableDateTime?.toIso8601String(),
                        "purchase_price": _purchasePriceController.text,
                        //"net_amount": _netAmmountController.text,
                        "net_amount": _calcNetPrice.text,
                        "attribute": arr
                      };

                      try {
                        var request = http.MultipartRequest(
                          'POST',
                          widget.productID == null
                              ? Uri.parse(
                                  '${AppURL.baseURL}api/inventory/store')
                              : Uri.parse(
                                  '${AppURL.baseURL}api/inventory/${widget.productID!}/update'),
                        );

                        // Add form fieldsF
                        formData.forEach((key, value) {
                          if (value != null) {
                            if (value is List) {
                              for (var item in value) {
                                request.fields['$key[]'] = item.toString();
                              }
                            } else if (value is Map) {
                              for (var item in value.entries) {
                                request.fields['$key[${item.key}]'] =
                                    item.value.toString();
                              }
                            } else {
                              request.fields[key] = value.toString();
                            }
                          }
                        });
                        // // Add images
                        for (var image in _imageFiles) {
                          request.files.add(await http.MultipartFile.fromPath(
                            'bluck_image[]',
                            image.path,
                          ));
                        }

                        // Add headers
                        request.headers.addAll({
                          'Authorization': 'Bearer ${_tokenService.token}',
                          'Accept': 'application/json',
                          'Content-Type': 'multipart/form-data',
                        });

                        print('Request Fields: ${request.fields}');
                        print('Request Headers: ${request.headers}');

                        // Prevent automatic redirection
                        request.followRedirects = false;

                        var response = await request.send();

                        print(response);

                        if (response.statusCode == 200) {
                          var responseBody =
                              await response.stream.bytesToString();
                          print("API Call Successful: $responseBody");
                          final InventoryActiveController _controller =
                              Get.put(InventoryActiveController());
                          _controller.fetchActiveProducts();
                          _controller.fetchInactiveProducts();
                          _controller.fetchOutOfStockProducts();
                          _controller.fetchOutOfStockProducts();
                        

                          Get.snackbar("Success", 'Inventory Update Successful',
                              backgroundColor: Colors.green,
                              colorText: Colors.white);

                          Get.to(Inventory(),
                              transition: Transition.leftToRightWithFade);

                          
                        } else if (response.statusCode == 302) {
                          // Handle Redirect
                          final redirectUrl = response.headers['location'];
                          if (redirectUrl != null) {
                            print("Redirect detected to: $redirectUrl");

                            var newRequest = http.MultipartRequest(
                                'POST', Uri.parse(redirectUrl));
                            newRequest.headers.addAll(request.headers);
                            newRequest.fields.addAll(request.fields);

                            // Re-add images to avoid "finalized MultipartFile" issue
                            for (var image in _imageFiles) {
                              newRequest.files
                                  .add(await http.MultipartFile.fromPath(
                                'bluck_image[]',
                                image.path,
                              ));
                            }

                            var newResponse = await newRequest.send();
                            var newResponseBody =
                                await newResponse.stream.bytesToString();
                            print(
                                "Retry Response: ${newResponse.statusCode} - $newResponseBody");
                          } else {
                            print("No redirect URL provided.");
                          }
                        } else if (response.statusCode == 500) {
                          var errorResponse =
                              await response.stream.bytesToString();
                          print("API Call Failed: 500 Internal Server Error");
                          print("Error Response: $errorResponse");
                          // Specific Error Handling for 500 Server Error
                          print("Possible causes for 500 error:");
                          print(
                              "- Invalid data or format being sent to the server.");
                          print(
                              "- Server-side issues (e.g., database or server errors).");
                          print("- Missing required fields.");
                          // Here you may want to alert the user or handle retries
                        } else {
                          var errorResponse =
                              await response.stream.bytesToString();
                          print("API Call Failed: ${response.statusCode}");
                          print("Error Response: $errorResponse");
                          // Print more specific errors based on status code
                          if (response.statusCode == 400) {
                            print(
                                "Bad Request: Likely missing or invalid fields.");
                          } else if (response.statusCode == 401) {
                            print("Unauthorized: Check token validity.");
                          } else if (response.statusCode == 403) {
                            print("Forbidden: You do not have permission.");
                          } else if (response.statusCode == 404) {
                            print("Not Found: The endpoint may be incorrect.");
                          } else {
                            print(
                                "Unexpected Error: Status code ${response.statusCode}");
                          }
                        }
                      } catch (e) {
                        print("API Call Error: $e");
                        // Log specific error type (e.g., network error, timeout, etc.)
                        print("Possible Causes:");
                        print("- Network issues.");
                        print("- Timeout.");
                        print("- Invalid URL.");
                      }
                    } else {
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
          );
        }),
      ),
    );
  }

  // Image picker widget showing selected images and option to add more
  Widget _buildImagePicker(List<ImageData> imagelist) {
    return Column(
      children: [
        if (_imageFiles.isEmpty)
          if (imagelist.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: imagelist.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Image.network(
                      imagelist[index].url,
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

  Widget _buildTagDropdown() {
    return Obx(() {
      if (tagController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (tagController.errorMessage.isNotEmpty) {
        return Center(child: Text(tagController.errorMessage.value));
      }
      return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Select a tag",
        ),
        items: tagController.tags.map((category) {
          return DropdownMenuItem<String>(
            value: category.name,
            child: Text(category.name),
          );
        }).toList(),
        onChanged: (String? selectedCategory) {
          if (selectedCategory != null &&
              !_selectedTags.contains(selectedCategory)) {
            setState(() {
              _selectedTags.add(selectedCategory);
            });
          }
        },
      );
    });
  }

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
  Widget _buildTextField(String hint,
      {String? label,
      int maxLines = 1,
      TextEditingController? controller,
      bool isRequired = false,
      bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
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

///////////////////////////////////////////////////////////////////////
////product
// Obx(() {
//   if (productController.isLoading.value) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
//   if (productController
//       .productList.isEmpty) {
//     return const Text(
//       "No products available.",
//       style: TextStyle(color: Colors.red),
//     );
//   }

//   return DropdownButtonFormField<String>(
//     value:
//         _selectedProduct, // Selected product
//     decoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius:
//             BorderRadius.circular(8.0),
//       ),
//       contentPadding:
//           const EdgeInsets.symmetric(
//               horizontal: 10),
//     ),
//     hint: const Text("Select a product"),
//     items: productController.productList
//         .map((product) {
//       return DropdownMenuItem<String>(
//         value: product.id
//             .toString(), // Assuming `id` is a string or convertible
//         child: Text(product.name ??
//             "Unnamed Product"),
//       );
//     }).toList(),
//     onChanged: (value) {
//       setState(() {
//         _selectedProduct =
//             value; // Update selected product
//       });
//       if (value != null) {
//         // Fetch attributes based on the selected product
//         attributeController.fetchAttributes(
//             int.parse(value));
//       }
//     },
//     validator: (value) {
//       if (value == null || value.isEmpty) {
//         return "Please select a product";
//       }
//       return null;
//     },
//   );
// }),


///////////////////////////////////////////////////////////////////////
                                    ////product ==>
                                    // Obx(() {
                                    //   if (productController.isLoading.value) {
                                    //     return const Center(
                                    //       child: CircularProgressIndicator(),
                                    //     );
                                    //   }
                                    //   if (productController
                                    //       .productList.isEmpty) {
                                    //     return const Text(
                                    //       "No products available.",
                                    //       style: TextStyle(color: Colors.red),
                                    //     );
                                    //   }

                                    //   return Container(
                                    //     height: 43,
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: 12),
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(5),
                                    //       color: Colors.white,
                                    //     ),
                                    //     child: DropdownButtonHideUnderline(
                                    //       child: DropdownButton(
                                    //         hint: Text(_selectedProduct,
                                    //             style: const TextStyle(
                                    //                 color: Colors.black)),
                                    //         icon: const Icon(
                                    //             Icons
                                    //                 .keyboard_double_arrow_down,
                                    //             size: 25),
                                    //         iconEnabledColor: Colors.red,
                                    //         iconDisabledColor: Colors.grey,
                                    //         isExpanded: true,
                                    //         items: productController.productList
                                    //             .map((items) {
                                    //           return DropdownMenuItem(
                                    //             value: items,
                                    //             child: Text(
                                    //                 items.name.toString(),
                                    //                 style: const TextStyle(
                                    //                     fontSize: 12)),
                                    //           );
                                    //         }).toList(),
                                    //         onChanged: (value) {
                                    //           setState(() {
                                    //             _selectedProduct =
                                    //                 value!.name.toString();
                                    //             _selectedProductId =
                                    //                 value.id.toString();
                                    //           });
                                    //           debugPrint(
                                    //               _selectedProduct.toString());
                                    //           debugPrint(_selectedProductId
                                    //               .toString());
                                    //         },
                                    //       ),
                                    //     ),
                                    //   );
                                    // }),
     // Obx(() {
                                    //   if (attributeController.isLoading.value) {
                                    //     return const Center(
                                    //         child: CircularProgressIndicator());
                                    //   }

                                    //   if (attributeController
                                    //       .attributes.isEmpty) {
                                    //     return const Center(
                                    //         child:
                                    //             Text("No attributes found."));
                                    //   }

                                    //   return ListView.builder(
                                    //     shrinkWrap: true,
                                    //     physics:
                                    //         const NeverScrollableScrollPhysics(),
                                    //     itemCount: attributeController
                                    //         .attributes.length,
                                    //     itemBuilder: (context, attributeIndex) {
                                    //       final attribute = attributeController
                                    //           .attributes[attributeIndex];
                                    //       return Padding(
                                    //         padding: const EdgeInsets.all(8.0),
                                    //         child: Column(
                                    //           crossAxisAlignment:
                                    //               CrossAxisAlignment.start,
                                    //           children: [
                                    //             Text(
                                    //               attribute.name,
                                    //               style: const TextStyle(
                                    //                 fontSize: 16,
                                    //                 fontWeight: FontWeight.bold,
                                    //               ),
                                    //             ),
                                    //             const SizedBox(height: 8),
                                    //             DropdownButtonFormField<String>(
                                    //               decoration: InputDecoration(
                                    //                 border:
                                    //                     OutlineInputBorder(),
                                    //                 labelText:
                                    //                     'Select ${attribute.name}',
                                    //               ),
                                    //               items: List.generate(
                                    //                 attribute.values.length,
                                    //                 (valueIndex) {
                                    //                   final attvalue = attribute
                                    //                       .values[valueIndex];
                                    //                   return DropdownMenuItem<
                                    //                       String>(
                                    //                     value: "${attvalue.id}",
                                    //                     child:
                                    //                         Text(attvalue.text),
                                    //                   );
                                    //                 },
                                    //               ),
                                    //               onChanged: (value) {
                                    //                 if (value != null) {
                                    //                   Map<String, dynamic>?
                                    //                       oldAttr =
                                    //                       attributeController
                                    //                           .selectedAttr;
                                    //                   oldAttr![
                                    //                           "${attribute.id}"] =
                                    //                       value;
                                    //                   attributeController
                                    //                           .selectedAttr =
                                    //                       oldAttr;
                                    //                 }
                                    //               },
                                    //             ),
                                    //             const SizedBox(height: 16),
                                    //           ],
                                    //         ),
                                    //       );
                                    //     },
                                    //   );
                                    // }),