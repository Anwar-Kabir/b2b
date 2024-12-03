import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'uom_controller.dart'; // Import the UomController file

class UomPage extends StatelessWidget {
  final UomController uomController = Get.put(UomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit of Measurement'),
      ),
      body: Obx(() {
        if (uomController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (uomController.uomList.isEmpty) {
          return const Center(child: Text("No data available"));
        }
        return ListView.builder(
          itemCount: uomController.uomList.length,
          itemBuilder: (context, index) {
            final uom = uomController.uomList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                 leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(uom.name),
                //subtitle: Text("ID: ${uom.id}"),
              ),
            );
          },
        );
      }),
    );
  }
}
