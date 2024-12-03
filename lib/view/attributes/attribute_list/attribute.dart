import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color.dart';
import '../add_attribute_value/add_attribute_value.dart';
import '../attribute_details/attribute_details_page.dart';
import '../create_attribute/create_attribute_page.dart';
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

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Spreads buttons across the row
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(
                              const AddAttributeValueForm(),
                              transition: Transition.rightToLeftWithFade,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blueGrey, // Custom button color
                          ),
                          child: const Text(
                            'Add Attribute Value',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(
                              const CreateAttributePage(),
                              transition: Transition.rightToLeftWithFade,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal, // Custom button color
                          ),
                          child: const Text(
                            'Add Attribute',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: attributesController.attributes.length,
                    itemBuilder: (context, index) {
                      final attribute = attributesController.attributes[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: SizedBox(
                          height: 115,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                AttributeDetailPage(attribute: attribute),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          'Categories: ${attribute.categories}',
                                          style: const TextStyle(
                                            fontSize: 14,
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
