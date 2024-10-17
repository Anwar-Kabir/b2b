import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/image.dart';
import 'package:isotopeit_b2b/utils/string.dart';
import 'package:isotopeit_b2b/view/splash/splash_controller.dart';

import '../../utils/color.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final splashController = Get.put(SplashController());

  @override
  void initState() {
    splashController.splashToLoginOrHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => AnimatedOpacity(
                opacity: splashController.textOpacity.value,
                duration: const Duration(seconds: 1),
                child: const Text(
                  AppStrings.splashScreenIntro,
                  style: TextStyle(
                    color: AppColor.appSplashScreenBG,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Obx(
              () => AnimatedOpacity(
                opacity: splashController.imageOpacity.value,
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  AppImages.splashLogo,
                  height: 353,
                  width: MediaQuery.of(context).size.width - 50,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Obx(
              () => AnimatedOpacity(
                opacity: splashController.indicatorOpacity.value,
                duration: const Duration(seconds: 1),
                child: const CircularProgressIndicator(color: AppColor.primaryColor,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
