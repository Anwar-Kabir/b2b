import 'package:get/get.dart';
import 'package:isotopeit_b2b/view/login/login.dart';

class SplashController extends GetxController {
  var textOpacity = 0.0.obs;
  var imageOpacity = 0.0.obs;
  var indicatorOpacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    goLogin();
  }

  void splashToLoginOrHome() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      textOpacity.value = 1.0;
    });

    // Animate the image opacity
    await Future.delayed(const Duration(milliseconds: 500), () {
      imageOpacity.value = 1.0;
    });

    // Animate the circular progress indicator
    await Future.delayed(const Duration(milliseconds: 500), () {
      indicatorOpacity.value = 1.0;
    });
  }

  Future<void> goLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() => const Login());
  }
}
