import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/inventory.dart/inven_product_details.dart';
import 'package:isotopeit_b2b/view/product/product_list_view.dart';

class ProductListCard extends StatelessWidget {
 

  const ProductListCard({super.key,  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
         
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Get.to(ProductListDetails(),
                  transition: Transition.rightToLeftWithFade);
            },
            child: SizedBox(
              height: 110,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Aligns items to the top
                    children: <Widget>[
                      // Image on the left (leading)
                      Container(
                        width: 80, // Set the width of the image
                        height: 80, // Set the height of the image
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded image corners
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/abc.jpg'), // Local asset image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    
                      const SizedBox(width: 12), // Space between image and text
                    
                      // Product details
                      const Expanded(
                        // Makes sure text occupies the remaining space
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Product name
                            Text(
                              "Korola (Bitter Gourd)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                    
                            SizedBox(
                                height: 6), // Space between product name and price
                    
                            // Price details
                            Text(
                              'Price: \$85.0',
                              style: TextStyle(color: AppColor.primaryColor),
                            ),
                            Text('Net Price: \$92.65'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
