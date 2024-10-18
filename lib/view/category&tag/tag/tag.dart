import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/view/category&tag/tag/controller_tag.dart';


class TagPage extends StatelessWidget {
  final TagController tagController = Get.put(TagController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tags'),
      ),
      body: Obx(() {
        if (tagController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (tagController.errorMessage.isNotEmpty) {
          return Center(child: Text(tagController.errorMessage.value));
        }

        return ListView.builder(
          itemCount: tagController.tags.length,
          itemBuilder: (context, index) {
            final tag = tagController.tags[index];
            return ListTile(
              title: Text(tag.name),
            );
          },
        );
      }),
    );
  }
}
