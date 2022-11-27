import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
                title: 'Log Out',
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
