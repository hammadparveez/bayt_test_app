import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:bayt_test_app/provider/locale_provider.dart';
import 'package:bayt_test_app/provider/theme_provider.dart';
import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:bayt_test_app/ui/first_app/bottom_navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class AccountUI extends StatelessWidget {
  const AccountUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: FractionallySizedBox(
            widthFactor: .8,
            child: ByatElevatedButton(
                title: 'log_out'.tr(),
                onTap: () {
                  context.read<FilterProvider>().onResetFilter();
                  Navigator.pushNamedAndRemoveUntil(
                      context, ByatRoute.main, (route) => false);
                }),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FractionallySizedBox(
              widthFactor: .8,
              child: ByatElevatedButton(
                  title: 'toggle_theme'.tr(),
                  onTap: context.read<ThemeProvider>().toggleMode),
            ),
          ),
        ),
        Center(
          child: FractionallySizedBox(
            widthFactor: .8,
            child: ByatElevatedButton(
                title: 'toggle_lang'.tr(),
                onTap: () {
                  context.read<LocaleProvider>().toggleLang(context);
                  context
                      .findAncestorStateOfType<BottomNavigationState>()
                      ?.refreshState();
                }),
          ),
        ),
      ],
    );
  }
}
