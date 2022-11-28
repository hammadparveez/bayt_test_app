import 'package:bayt_test_app/ui/auth/login.dart';
import 'package:bayt_test_app/ui/bottom_navigation/bottom_navigation.dart';
import 'package:bayt_test_app/ui/user_detail/user_detail.dart';

import 'package:flutter/material.dart';

class ByatRoute {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static const main = '/main';
  static const login = '/login';
  static const userDetail = '/user/detail';
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return _pageWrapper(const BottomNavigationUI());
      case login:
        return _pageWrapper(const LoginUI());
        case userDetail:
        return _pageWrapper(const UserDetailUI());
    }
  }

  static MaterialPageRoute _pageWrapper(Widget screen) =>
      MaterialPageRoute(builder: (_) => screen);
}
