import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/helper/connectivity_service.dart';
import 'package:isotopeit_b2b/helper/language_controller.dart';
import 'package:isotopeit_b2b/helper/theme_controller.dart';
import 'package:isotopeit_b2b/helper/token_service.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/utils/translations/translations.dart';
import 'package:isotopeit_b2b/view/BottomNav.dart';
import 'package:isotopeit_b2b/view/splash/splash.dart';
import 'package:isotopeit_b2b/widget/no_internet_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await TokenService().init();
  Get.put(ConnectivityService());
  Get.put(LanguageController()); // Only initialize once
  Get.put(ThemeController());

  // runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.find();
    final ThemeController themeController = Get.find();

    return Obx(() {
      // Check the current language code and set directionality
      final isRtl = languageController.locale.value.languageCode == 'ar';

      return Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: ScreenUtilInit(
          designSize: Size(360, 690),
          builder: (context, child) {
            return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          translations: AppTranslations(),
          locale: languageController.locale.value,
          fallbackLocale: const Locale('en', 'US'),
          //darkTheme: ThemeData.dark(),
          darkTheme: ThemeData.dark().copyWith(
            brightness: Brightness.dark,
             // colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
                  appBarTheme: const AppBarTheme(
                    color: Colors.black, // Background color in dark mode
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                    iconTheme: IconThemeData(color: Colors.white), // Icon color
                  ),
                ),
          theme: 
          // ThemeData.light().copyWith(
          //   colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          //   useMaterial3: true,
          // ),
          ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
                  useMaterial3: true,
                  appBarTheme:   AppBarTheme(
                    //color: AppColor.primaryColor.withOpacity(0.8), // Background color of AppBar
                    backgroundColor: AppColor.primaryColor.withOpacity(0.8), 
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                    iconTheme: IconThemeData(color: Colors.white), // Icon color
                  ),
                ),
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          home: FutureBuilder<bool>(
            future: _checkInternetConnection(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data!) {
               // return const Splash();
                return   BottomNav();  
              } else {
                return const NoInternetPage(); // Show no internet page if not connected
              }
            },
          ),
        );
          },
        )
        
      );
    });
  }

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}

//initialRoute: RoutesName.splashScreen
//onGenerateRoute: Routes.generateRoute
//Navigator.pushnamed(context, Routesname.splashScreen);
