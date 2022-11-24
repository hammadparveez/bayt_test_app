import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginUI extends StatelessWidget {
  const LoginUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Image.asset('assets/logo.png', height: 50, width: 50),
              const Align(
                  alignment: Alignment.centerLeft, child: Text('Sign In')),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'example@byat.com',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: .5)),
                  // border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              FractionallySizedBox(
                widthFactor: .7,
                child: ByatElevatedButton(
                    title: 'Sign In', onTap: () {}, hasSuffixIcon: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
