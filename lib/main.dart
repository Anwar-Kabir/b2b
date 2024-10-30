import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/helper/connectivity_service.dart';
import 'package:isotopeit_b2b/helper/theme_controller.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/view/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize TokenService to load saved token
  await TokenService().init();

  // Initialize ConnectivityService to track connectivity status
  Get.put(ConnectivityService());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

final ConnectivityService connectivityService =
    ConnectivityService(); // Global instance

final ThemeController themeController = Get.put(ThemeController());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            darkTheme: ThemeData.dark(),
            theme: ThemeData.light().copyWith(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
              useMaterial3: true,
            ),
            themeMode: themeController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const Splash(),
          );
        });
  }
}
