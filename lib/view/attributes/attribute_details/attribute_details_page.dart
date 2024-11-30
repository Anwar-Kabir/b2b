import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/utils/color.dart';

import '../attribute_list/attribute_model.dart';

part './widgets/details_data_row.dart';

class AttributeDetailPage extends StatelessWidget {
  const AttributeDetailPage({super.key, required this.attribute});

  final Attribute attribute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attribute Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Attribute Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DetailsDataRow(
                title: 'Attribute Name:',
                value: attribute.name ?? '',
              ),
              DetailsDataRow(
                title: 'Entities:',
                value: attribute.attributeValueCount.toString(),
              ),
              DetailsDataRow(
                title: 'Sub Sub Category:',
                value: attribute.categories ?? '',
              ),
              const SizedBox(height: 25),
              DottedLine(
                dashColor: Colors.black.withOpacity(0.2),
              ),
              const SizedBox(height: 25),
              const Text(
                'Attribute Values',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('White',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green.withOpacity(0.2),
                                child: IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.green),
                                  onPressed: () {
                                    // Implement your edit functionality here
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.red.withOpacity(0.2),
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    // Implement your delete functionality here
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Text('#fffff', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
