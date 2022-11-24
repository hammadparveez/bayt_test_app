import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:bayt_test_app/ui/base_widiget/loader_dialog.dart';
import 'package:bayt_test_app/ui/base_widiget/message_dialog.dart';
import 'package:bayt_test_app/ui/base_widiget/text_field.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginUI extends StatelessWidget {
  const LoginUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 8),
            const Text('Eventhub',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Sign In',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w700))),
            const SizedBox(height: 20),
            ByatTextField(
                hintText: 'example@byat.com',
                prefixIcon: const Icon(Icons.email)),
            const SizedBox(height: 20),
            ByatTextField(
                isPassword: true,
                suffixIcon: const Icon(Icons.remove_red_eye),
                prefixIcon: const Icon(Icons.lock)),
            const SizedBox(height: 30),
            FractionallySizedBox(
              widthFactor: .7,
              child: ByatElevatedButton(
                title: 'Sign In',
                onTap: () => Navigator.pushNamed(context, ByatRoute.home),
                hasSuffixIcon: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
