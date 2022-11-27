import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
      ],
    );
  }
}
