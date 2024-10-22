import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color.dart';
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
          'Attribute Value',
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
                labelText: "Categories",
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

                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  hint: const Text('Select'),
                  items: categoryController.categories
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
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
                      : () {
                          if (_controller.validateForm()) {
                            _controller.createAttribute(
                              [
                                selectedCategory.toString(),
                              ],
                            );
                          }
                          print(
                              "====>>> sent category group name $selectedCategory");
                        },
                  icon: const Icon(Icons.add),
                  label: _controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Save Attribute value"),
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
