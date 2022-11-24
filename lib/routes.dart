import 'package:bayt_test_app/ui/auth/login.dart';
import 'package:flutter/material.dart';

class ByatRoute {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static const home = '/home';
  static const login = '/login';
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _pageWrapper(Container());
      case login:
        return _pageWrapper(const LoginUI());
    }
  }

  static MaterialPageRoute _pageWrapper(Widget screen) =>
      MaterialPageRoute(builder: (_) => screen);
}
