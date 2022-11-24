import 'package:bayt_test_app/provider/mock_provider.dart';
import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ByatApp());
}

class ByatApp extends StatelessWidget {
  const ByatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MockProvider(),
      child: MaterialApp(
        title: 'Byat Test App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            cardColor: ByatColors.primary,
            radioTheme: RadioThemeData(
                fillColor: MaterialStateProperty.all(ByatColors.white)),
            colorScheme: ColorScheme.light(
                primary: ByatColors.primary, onSurface: ByatColors.white)),
        navigatorKey: ByatRoute.navigatorKey,
        onGenerateRoute: ByatRoute.onGenerateRoute,
        initialRoute: ByatRoute.login,
      ),
    );
  }
}
