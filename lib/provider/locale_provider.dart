import 'package:bayt_test_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LocaleProvider {
  void toggleLang() {
    final ctx = ByatRoute.navigatorKey.currentContext!;
    if (ctx.locale.languageCode == 'en') {
      ctx.setLocale(const Locale('ar'));
    } else {
      ctx.setLocale(const Locale('en'));
    }
  }
}
