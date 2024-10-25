import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/helper/connectivity_service.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/view/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize TokenService to load saved token
  await TokenService().init();

  // Initialize ConnectivityService to track connectivity status
    Get.put(ConnectivityService()); 

  runApp(const MyApp());
}

final ConnectivityService connectivityService =
    ConnectivityService(); // Global instance

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          useMaterial3: true,
        ),
        // home: const Splash (),
        home: const Splash());
  }
}
