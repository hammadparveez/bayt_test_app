import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:bayt_test_app/provider/search_provider.dart';

import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences? pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  runApp(const ByatApp());
}

class ByatApp extends StatelessWidget {
  const ByatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        
      ],
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
