import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:bayt_test_app/ui/base_widiget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginUI extends StatelessWidget {
  const LoginUI({super.key});

  @override
  Widget build(BuildContext context) {
    final hasNotInsets = MediaQuery.of(context).viewInsets.bottom == 0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 8),
                      child: Text(
                        'Hello Again!',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      ),
                    ),
                    // if (hasNotInsets)
                    Text(
                      'Welcome back you\'ve\nbeen missed!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: hasNotInsets ? 50 : 30),
                    ByatTextField(
                      hintText: 'Enter your email',
                    ),
                    SizedBox(height: 20),
                    ByatTextField(hintText: 'Password'),
                    SizedBox(height: 8),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {}, child: Text('Forget Password'))),
                    SizedBox(height: hasNotInsets ? 24 : 8),
                    ByatElevatedButton(title: 'sign_in'.tr(), onTap: () {}),
                  ],
                ),
              ),
              if (hasNotInsets)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 10),
                        child: Row(
                          children: const [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Or continue with'),
                            ),
                            Expanded(child: Divider())
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: .5)),
                            child: Image.asset('assets/google.png',
                                fit: BoxFit.contain),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            padding: const EdgeInsets.all(8),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: .5)),
                            child: Image.asset('assets/facebook.png',
                                fit: BoxFit.contain),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
