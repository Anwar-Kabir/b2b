import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/view/banner/controller_banner.dart';
 

class BannerManager extends StatelessWidget {
  final BannerController bannerController = Get.put(BannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Banners",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:  AppColor.primaryColor.withOpacity(0.7),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to Add Banner
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (bannerController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (bannerController.banners.isEmpty) {
          return const Center(
            child: Text('No banners available'),
          );
        } else {
          return ListView.builder(
            itemCount: bannerController.banners.length,
            itemBuilder: (context, index) {
              final banner = bannerController.banners[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to BannerDetails
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    height: 145,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(int.parse(banner.bgColor.replaceAll(
                                    '#', '0xff'))), // Background color
                              ),
                              child: Image.asset(AppImages.splashLogo) ,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    banner.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Columns: ${banner.columns}, Serial Number: ${banner.order}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Link label: ${banner.linkLabel ?? 'null'}, Link: ${banner.link ?? 'null'}',
                                  ),
                                  Text(
                                    'Description: ${banner.description}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                  
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.blue.withOpacity(0.2),
                                  child: IconButton(
                                    onPressed: () {
                                      // Implement edit functionality here
                                    },
                                    icon:
                                        const Icon(Icons.edit, color: Colors.blue),
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                CircleAvatar(
                                    backgroundColor: Colors.red.withOpacity(0.2),
                                  
                                  child: IconButton(
                                    onPressed: () {
                                      // Implement delete functionality here
                                    },
                                    icon:
                                        const Icon(Icons.delete, color: Colors.red),
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
        }
      }),
    );
  }
}
