import 'package:flutter/material.dart';
import 'package:isotopeit_b2b/utils/routes/routes_name.dart';
import 'package:isotopeit_b2b/view/login/login.dart';
import 'package:isotopeit_b2b/view/splash/splash.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const Splash());
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => const Login());  
      default:
        return MaterialPageRoute(builder: (conntext) {
          return const Scaffold(
            body: Center(
              child: Text("No route generate"),
            ),
          );
        });
    }
  }
}
