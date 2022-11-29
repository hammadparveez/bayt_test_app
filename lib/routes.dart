import 'package:bayt_test_app/ui/first_app/bottom_navigation/bottom_navigation.dart';
import 'package:bayt_test_app/ui/first_app/startup/start_up.dart';
import 'package:bayt_test_app/ui/first_app/user_detail/user_detail.dart';

import 'package:flutter/material.dart';

class ByatRoute {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static const main = '/main';
  static const home = '/home';

  static const userDetail = '/user/detail';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return _pageWrapper(const StartUpUI());
      case home:
        return _pageWrapper(const BottomNavigationUI());

      case userDetail:
        return _pageWrapper(const UserDetailUI());
    }
  }

  static MaterialPageRoute _pageWrapper(Widget screen) =>
      MaterialPageRoute(builder: (_) => screen);
}
