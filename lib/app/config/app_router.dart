import 'package:flutter/material.dart';
import 'package:flutter_demo_auth/app/constants/routes_const.dart';
import 'package:flutter_demo_auth/screens/init/view/init_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => Container());
      default:
        return MaterialPageRoute(builder: (_) => const InitScreen());
    }
  }
}
