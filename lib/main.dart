import 'package:bayt_test_app/provider/filter_provider.dart';

import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences? pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
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
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'Byat Test App',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
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
          );
        }),
      ),
    );
  }
}
