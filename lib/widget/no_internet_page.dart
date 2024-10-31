// no_internet_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/helper/connectivity_service.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("No Internet", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("Please check your internet or Wi-Fi connection."),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retry checking connection
                Get.find<ConnectivityService>().checkConnection();
              },
              child: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}



  