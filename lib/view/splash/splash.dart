import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/view/splash/splash_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/color.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  final splashController = Get.put(SplashController());

  late AnimationController _controller;
  late Animation<double> _textAnimation;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    Timer(const Duration(seconds: 5), () {
      splashController.splashToLoginOrHome();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    const colorizeColors = [
      AppColor.pykariDark,
      AppColor.pykariPrimary,
      AppColor.pykariDark
    ];

    return Scaffold(
      body: Container(
        color: AppColor.pykariBody,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _textAnimation,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/logos/logo_mini.png',
                                width: 120.w),
                            AnimatedTextKit(animatedTexts: [
                              ColorizeAnimatedText(
                                "PYKARI.COM",
                                textStyle: GoogleFonts.robotoCondensed(
                                  textStyle: TextStyle(
                                    fontSize: 32.sp,
                                    letterSpacing: 5.w,
                                    fontWeight: FontWeight.w600,
                                    shadows: const [
                                      Shadow(
                                        color: AppColor.pykariDark,
                                        blurRadius: 2,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                colors: colorizeColors,
                                speed: const Duration(milliseconds: 500),
                              )
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Technology Partner Isotope IT Ltd.",
                      style: TextStyle(
                          color: AppColor.pykariTitle,
                          fontWeight: FontWeight.w400,
                          fontSize: 11),
                    ),
                    Image.asset('assets/logos/isotopeit.png', width: 70.w)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
