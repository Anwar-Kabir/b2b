import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/signup/signup_controller.dart';
import 'package:isotopeit_b2b/widget/custom_text_field.dart';
import 'package:isotopeit_b2b/widget/label_with_asterisk.dart';

class AttributeValueForm extends StatefulWidget {
  const AttributeValueForm({super.key});

  @override
  State<AttributeValueForm> createState() => _AttributeValueFormState();
}

class _AttributeValueFormState extends State<AttributeValueForm> {
  final SignupController _controller = Get.put(SignupController());

  final TextEditingController attributeValueController =
      TextEditingController();
  final TextEditingController listOrderController = TextEditingController();
  Color selectedColor = Colors.black;
  String? selectedAttribute;

  // Dummy data for the dropdown
  final List<String> attributes = ['TV', 'Phone', 'Computer'];

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelWithAsterisk(
              labelText: "Categories",
              isRequired: true,
            ),

            // Attribute Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                //labelText: 'Attribute *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              hint: const Text('Select'),
              items: attributes
                  .map((attribute) => DropdownMenuItem<String>(
                        value: attribute,
                        child: Text(attribute),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedAttribute = value;
                });
              },
            ),
            const SizedBox(height: 16.0),

            // Attribute Value TextField

            const LabelWithAsterisk(
              labelText: "Attribute name",
              isRequired: true,
            ),

            CustomTextField(
              prefixIcon: Icons.email,
              hintText: 'Attribute name',
              controller: _controller.appEmailValidator,
              keyboardType: TextInputType.emailAddress,
              //validator: _controller.validateEmail,
            ),

            const SizedBox(height: 16.0),

            const LabelWithAsterisk(
              labelText: "List order ",
              isRequired: true,
            ),

            CustomTextField(
              prefixIcon: Icons.email,
              hintText: '4',
              controller: _controller.appEmailValidator,
              keyboardType: TextInputType.emailAddress,
              //validator: _controller.validateEmail,
            ),
            // List Order TextField

            const SizedBox(height: 16.0),

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
