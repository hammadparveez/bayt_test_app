import 'package:bayt_test_app/ui/auth/login.dart';
import 'package:bayt_test_app/ui/bottom_navigation/bottom_navigation.dart';

import 'package:flutter/material.dart';

class ByatRoute {
  static const main = '/main';
  static const login = '/login';
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return _pageWrapper( const BottomNavigationUI());
      case login:
        return _pageWrapper(const LoginUI());
    }
  }

  static MaterialPageRoute _pageWrapper(Widget screen) =>
      MaterialPageRoute(builder: (_) => screen);
}
