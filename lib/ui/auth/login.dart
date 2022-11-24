import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:bayt_test_app/ui/base_widiget/text_field.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginUI extends StatelessWidget {
  const LoginUI({super.key});

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    final screenHeight = mQuery.size.height;
    final bottomInsets = mQuery.viewInsets.bottom;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SizedBox(
            height: screenHeight - bottomInsets,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          child: FractionallySizedBox(
                            heightFactor: .7,
                            child: Image.asset(
                              'assets/logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text('Eventhub',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700))
                      ],
                    )),
                // const SizedBox(height: 30),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Sign In',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700))),
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
                          onTap: () {},
                          hasSuffixIcon: true,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
