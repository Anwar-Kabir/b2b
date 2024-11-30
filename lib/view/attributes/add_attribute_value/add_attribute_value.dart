import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/attributes/add_attribute_value/controller/add_attribute_value_controller.dart';
import 'package:isotopeit_b2b/view/attributes/add_attribute_value/controller/add_attribute_value_create_controller.dart';
import 'package:isotopeit_b2b/view/attributes/add_attribute_value/model/add_attribute_value_create_model.dart';
 
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';

import '../../inventory/inventory_details/inventory_product_details_model.dart';

class AddAttributeValueForm extends StatefulWidget {
  const AddAttributeValueForm({super.key});

  @override
  State<AddAttributeValueForm> createState() => _AddAttributeValueFormState();
}

class _AddAttributeValueFormState extends State<AddAttributeValueForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController attributeValueController =
      TextEditingController();
  final TextEditingController listOrderController = TextEditingController();
  Color selectedColor = Colors.black;

  final AttributeController attributeController =
      Get.put(AttributeController());
  String? selectedAttributeName;
  int? selectedAttributeId;

  @override
  void initState() {
    super.initState();
    attributeController.fetchAttributes();
  }

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Select'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void saveAttributeValue() {
    if (_formKey.currentState?.validate() ?? false) {
      if (selectedAttributeId == null) {
        Get.snackbar(
          'Validation Error',
          'Please select an attribute.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Create the AttributeValue model
      final attributeValue = AttributeValueCreateModel(
        attributeId: selectedAttributeId!,
        value: attributeValueController.text,
        color: selectedColor.value.toRadixString(16),
        order: int.parse(listOrderController.text),
      );

      // Call the API
      final AddAttributeValueCreateController controller =
          Get.put(AddAttributeValueCreateController());
      controller.createAttributeValue(attributeValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Attribute Value',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LabelWithAsterisk(
                labelText: "Attribute",
                isRequired: true,
              ),
              Obx(() {
                if (attributeController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (attributeController.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(attributeController.errorMessage.value),
                  );
                }

                return DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                  hint: const Text('Select Attribute'),
                  items: attributeController.attributes
                      .map(
                        (attribute) => DropdownMenuItem<int>(
                          value: attribute.id,
                          child: Text(attribute.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAttributeId = value;
                      selectedAttributeName = attributeController.attributes
                          .firstWhere((attr) => attr.id == value)
                          .name;
                    });
                  },
                );
              }),
              const SizedBox(height: 16.0),
              const LabelWithAsterisk(
                labelText: "Attribute value",
                isRequired: true,
              ),
              TextFormField(
                controller: attributeValueController,
                decoration: InputDecoration(
                  hintText: 'Enter Attribute Value',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an attribute value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const LabelWithAsterisk(
                labelText: "List Order",
                isRequired: true,
              ),
              TextFormField(
                controller: listOrderController,
                decoration: InputDecoration(
                  hintText: 'Enter List Order',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the list order';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text('Color attribute: '),
                  GestureDetector(
                    onTap: () => pickColor(context),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: selectedColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: saveAttributeValue,
                icon: const Icon(Icons.add),
                label: const Text("Save Attribute Value"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
