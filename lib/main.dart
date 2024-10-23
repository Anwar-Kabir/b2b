import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/color.dart';
import 'package:isotopeit_b2b/view/signup/signup.dart';
import 'package:isotopeit_b2b/view/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

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
      home: const Splash (),
    );
  }
}
