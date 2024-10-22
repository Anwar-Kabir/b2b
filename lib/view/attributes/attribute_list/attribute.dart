import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/attributes/add_attribute_value/add_attribute_value.dart';
import 'package:isotopeit_b2b/view/attributes/attribute_details/attribute_deatils.dart';
import 'package:isotopeit_b2b/view/attributes/attribute_value/attribute_value.dart';

import 'attribute_controller.dart';

class AttributeListPage extends StatelessWidget {
  AttributeListPage({super.key});

  final AttributesController attributesController =
      Get.put(AttributesController());

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
        actions: [
          TextButton.icon(
            onPressed: () {
              Get.to(const AddAttributeValueForm(),
                  transition: Transition.rightToLeftWithFade);
            },
            label: const Text(
              "AAV",
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          TextButton.icon(
            onPressed: () {
              Get.to(const AttributeValueForm(),
                  transition: Transition.rightToLeftWithFade);
            },
            label: const Text(
              "AV",
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Obx(
        () {
          if (attributesController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (attributesController.errorMessage.isNotEmpty) {
            return Center(child: Text(attributesController.errorMessage.value));
          }

          if (attributesController.attributes.isEmpty) {
            return const Center(child: Text('No attributes available'));
          }

          return ListView.builder(
            itemCount: attributesController.attributes.length,
            itemBuilder: (context, index) {
              final attribute = attributesController.attributes[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: SizedBox(
                  height: 95,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        const AttributeDetails(),
                        transition: Transition.rightToLeftWithFade,
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Attribute: ${attribute.name}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Entities: ${attribute.attributeValueCount}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
