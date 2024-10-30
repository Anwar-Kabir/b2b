import 'package:get/get.dart';
import 'package:isotopeit_b2b/view/BottomNav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isotopeit_b2b/view/login/login.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    splashToLoginOrHome();
  }

  void splashToLoginOrHome() async {
     await checkToken();
    // Get.to(OrderDeatils());
  }

  Future<void> checkToken() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      // If token exists, navigate to Home
      Get.offAll(() => const BottomNav(),
          transition: Transition.rightToLeftWithFade);
    } else {
      // If no token, navigate to Login
      Get.offAll(() => const Login(),
          transition: Transition.rightToLeftWithFade);
    }
  }
}
