import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/attributes/add_attribute_value.dart';
import 'package:isotopeit_b2b/view/attributes/attribute_deatils.dart';
import 'package:isotopeit_b2b/view/attributes/attribute_value.dart';

class SizeColorManager extends StatefulWidget {
  @override
  _SizeColorManagerState createState() => _SizeColorManagerState();
}

class _SizeColorManagerState extends State<SizeColorManager> {
  @override
  void initState() {
    super.initState();
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
          actions: [
            TextButton.icon(
              onPressed: () {
                Get.to(AddAttributeValueForm(),
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
                Get.to(AttributeValueForm(),
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
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
                height: 95,
                child: GestureDetector(
                  onTap: () {
                    Get.to(const AttributeDeatils(), transition: Transition.rightToLeftWithFade);
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          // Add border color and width
                          color:
                              Colors.grey, // Change this to your desired color
                          width: 2, // Set the border width
                        ),
                      ),
                      elevation: 4,
                      child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Order Details
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Attribute: Color',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 8),
                                  Text('Entities, 5'),
                                  SizedBox(height: 4),
                                ],
                              ),
                            ],
                          ))),
                ))));
  }
}
