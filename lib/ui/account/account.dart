import 'package:bayt_test_app/provider/locale_provider.dart';
import 'package:bayt_test_app/provider/theme_provider.dart';
import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, ByatRoute.login, (route) => false);
                }),
          ),
        ),
        Center(
          child: FractionallySizedBox(
            widthFactor: .8,
            child: ByatElevatedButton(
                title: 'toggle_theme'.tr(),
                onTap: context.read<ThemeProvider>().toggleMode),
          ),
        ),
        Center(
          child: FractionallySizedBox(
            widthFactor: .8,
            child: ByatElevatedButton(
                title: 'toggle_lang'.tr(),
                onTap: context.read<LocaleProvider>().toggleLang),
          ),
        ),
      ],
    );
  }
}
