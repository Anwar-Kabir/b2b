import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/helper/connectivity_service.dart';
import 'package:isotopeit_b2b/helper/theme_controller.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/view/login/login.dart';
import 'package:isotopeit_b2b/view/signup/signup.dart';
import 'package:isotopeit_b2b/view/splash/splash.dart';
import 'package:isotopeit_b2b/widget/no_internet_page.dart';

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
final ThemeController themeController = Get.put(ThemeController());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
        useMaterial3: true,
      ),
      themeMode:
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      home: FutureBuilder<bool>(
        future: _checkInternetConnection(), // Check connection status
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Loading indicator while checking
          } else if (snapshot.hasData && snapshot.data!) {
            return const Splash(); // Show splash if connected
          } else {
            return const NoInternetPage(); // Show no internet page if not connected
          }
        },
      ),
    );
  }

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
