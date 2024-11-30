import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color.dart';
import '../attribute_list/attribute.dart';
import 'category_group_controller.dart';
import 'create_attribute_controller.dart';

part './widgets/_label_with_requirement.dart';

class CreateAttributePage extends StatefulWidget {
  const CreateAttributePage({super.key});

  @override
  State<CreateAttributePage> createState() => _CreateAttributePageState();
}

class _CreateAttributePageState extends State<CreateAttributePage> {
  final CreateAttributeController _controller = Get.put(
    CreateAttributeController(),
  );
  final CategoryGroupController categoryController = Get.put(
    CategoryGroupController(),
  );

  String? selectedCategory;
  String? selectedCategoryID;

  @override
  void initState() {
    super.initState();
    categoryController.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attribute',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Form(
        key: _controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _LabelWithRequirement(
                labelText: "Sub Sub Categories",
                isRequired: true,
              ),
              Obx(() {
                if (categoryController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (categoryController.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text(categoryController.errorMessage.value));
                }
                return DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  hint: const Text('Select Category'),
                  items: categoryController.categories.map((category) {
                    return DropdownMenuItem<int>(
                      value: category.id, // Store ID as the value
                      child: Text(category.name), // Display the name
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategoryID =
                          value.toString(); // Store selected ID
                      selectedCategory = categoryController.categories
                          .firstWhere((category) => category.id == value)
                          .name; // Store selected name
                      print("Selected Category ID: $selectedCategoryID");
                      print("Selected Category Name: $selectedCategory");
                    });
                  },
                );
              }),
              const SizedBox(height: 16.0),
              const _LabelWithRequirement(
                labelText: "Attribute name",
                isRequired: true,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.label),
                  hintText: 'Attribute name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: _controller.nameController,
                validator: _controller.validateName,
              ),
              const SizedBox(height: 16.0),
              const _LabelWithRequirement(
                labelText: "List order",
                isRequired: true,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.list),
                  hintText: '4',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: _controller.orderController,
                keyboardType: TextInputType.number,
                validator: _controller.validateOrder,
              ),
              const Spacer(),
              Obx(() {
                return ElevatedButton.icon(
                   onPressed: _controller.isLoading.value
                      ? null
                      : () async {
                          if (_controller.validateForm()) {
                            if (selectedCategoryID != null) {
                              print("Category ID: $selectedCategoryID");
                              print(
                                  "Attribute Name: ${_controller.nameController.text}");
                              print(
                                  "Order: ${_controller.orderController.text}");

                              // Call the API with required parameters
                              await _controller.createAttribute(
                                name: _controller.nameController.text,
                                order:
                                    int.parse(_controller.orderController.text),
                                categories: [
                                  selectedCategoryID!
                                ], // Pass the category ID list
                              );
                            } else {
                              Get.snackbar(
                                "Error",
                                "Please select a valid category",
                                backgroundColor:
                                    Colors.red.shade200.withOpacity(0.4),
                              );
                            }
                          }
                        },

                  icon: const Icon(Icons.add),
                  label: _controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Save Attribute"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColor.primaryColor.withOpacity(0.7),
                    foregroundColor: Colors.white,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
