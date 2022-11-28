import 'package:bayt_test_app/provider/auth_provider.dart';
import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:bayt_test_app/provider/search_provider.dart';
import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ByatApp extends StatelessWidget {
  const ByatApp({super.key});
  final localePath = 'assets/translations';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProxyProvider<FilterProvider, SearchProvider>(
            create: (_) => SearchProvider(),
            update: (_, filterProvider, searchProvider) =>
                searchProvider!..update(filterProvider)),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: localePath,
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
              // radioTheme: RadioThemeData(
              //     fillColor: MaterialStateProperty.all(ByatColors.white)),
              colorScheme: ColorScheme.light(
                primary: ByatColors.primary,
                secondary: Color(0xff00ff00),
                onSecondary: Color(0xff00ff00),
              ),
            ),
            onGenerateRoute: ByatRoute.onGenerateRoute,
            initialRoute: ByatRoute.login,
          );
        }),
      ),
    );
  }
}
