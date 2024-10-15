import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/utils/color.dart';

class AttributeDeatils extends StatelessWidget {
  const AttributeDeatils({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attribute Deatils',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
              _buildDetailRow('Attribute Name:', 'Color'),
              _buildDetailRow('Entites:', '5'),
              _buildDetailRow('Sub Sub Category:', 'food, fish, meet'),
               
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
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('White',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green.withOpacity(0.2),
                                child: IconButton(
                                  icon: Icon(Icons.edit, color: Colors.green),
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
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // Implement your delete functionality here
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text('#fffff', style: TextStyle(fontSize: 16)),
                     
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

   

  Widget _buildDetailRow(String title, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Aligns title and value
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

   
}
