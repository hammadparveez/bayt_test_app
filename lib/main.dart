import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ByatApp());
}

class ByatApp extends StatelessWidget {
  const ByatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Byat Test App',
      theme: ThemeData(primaryColor: ByatColors.primary),
      navigatorKey: ByatRoute.navigatorKey,
      onGenerateRoute: ByatRoute.onGenerateRoute,
      initialRoute: ByatRoute.login,
    );
  }
}
