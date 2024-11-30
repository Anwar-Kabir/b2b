import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/attributes/create_attribute/category_group_controller.dart';
import 'package:isotopeit_b2b/view/signup/signup_controller.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';

class AddAttributeValueForm extends StatefulWidget {
  const AddAttributeValueForm({super.key});

  @override
  State<AddAttributeValueForm> createState() => _AddAttributeValueFormState();
}

class _AddAttributeValueFormState extends State<AddAttributeValueForm> {
  final SignUpController _controller = Get.put(SignUpController());
   final CategoryGroupController categoryController = Get.put(
    CategoryGroupController(),
  );

  final TextEditingController attributeValueController =
      TextEditingController();
  final TextEditingController listOrderController = TextEditingController();
  Color selectedColor = Colors.black;
  String? selectedAttribute;

  

  // Function to show the color picker dialog
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelWithAsterisk(
              labelText: "Attribute",
              isRequired: true,
            ),

           
           DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              hint: const Text('Select Category'),
              items: categoryController.categories
                  .map((category) => DropdownMenuItem<String>(
                        value: category, // Assuming 'category' is a string
                        child: Text(
                          category.replaceAll(
                              '<br>', ', '), // Handle <br> replacement
                          overflow: TextOverflow
                              .ellipsis, // Handle long text gracefully
                          maxLines: 1, // Limit to one line
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedAttribute = value; // Update selected attribute
                });
              },
            ),


            const SizedBox(height: 16.0),

            // Attribute Value TextField

            const LabelWithAsterisk(
              labelText: "Attribute value",
              isRequired: true,
            ),

            CustomTextField(
              prefixIcon: Icons.email,
              hintText: 'Attribute value',
              controller: listOrderController,
              keyboardType: TextInputType.emailAddress,
              //validator: _controller.validateEmail,
            ),

            const SizedBox(height: 16.0),

            const LabelWithAsterisk(
              labelText: "List Order",
              isRequired: true,
            ),

            CustomTextField(
              prefixIcon: Icons.email,
              hintText: '4',
              controller: listOrderController,
              keyboardType: TextInputType.emailAddress,
              //validator: _controller.validateEmail,
            ),
            // List Order TextField

            const SizedBox(height: 16.0),

            // Color Picker
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
            const SizedBox(height: 16.0),

            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Save Attribute value"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColor.primaryColor,
                // For text color:
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





 