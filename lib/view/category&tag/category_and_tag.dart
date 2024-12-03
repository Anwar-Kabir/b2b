


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/category&tag/controller_category_tag.dart';
import 'package:isotopeit_b2b/view/category&tag/tag/controller_tag.dart';


class CategoryTagPage extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final TagController tagController =
      Get.put(TagController()); // Initialize TagController

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Category and Tag
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tag',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColor.primaryColor.withOpacity(0.7),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
           
        ),
        body: Obx(() {
          if (tagController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (tagController.errorMessage.isNotEmpty) {
            return Center(child: Text(tagController.errorMessage.value));
          } else {
            return ListView.builder(
              itemCount: tagController.tags.length,
              itemBuilder: (context, index) {
                final tag = tagController.tags[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        tag.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
