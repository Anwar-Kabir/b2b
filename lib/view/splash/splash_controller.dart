import 'package:get/get.dart';
import 'package:isotopeit_b2b/view/BottomNav.dart';
import 'package:isotopeit_b2b/view/order/order_details/order_deatils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isotopeit_b2b/view/login/login.dart';

class SplashController extends GetxController {
  var textOpacity = 0.0.obs;
  var imageOpacity = 0.0.obs;
  var indicatorOpacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    splashToLoginOrHome();
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

    // Check for token and navigate accordingly
     await checkToken();
    //Get.to(OrderDeatils());
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
