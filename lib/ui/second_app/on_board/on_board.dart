
import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:flutter/material.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({required this.onGetStarted, super.key});
  final VoidCallback onGetStarted;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Byat',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const _OnBaord1(),
              ByatElevatedButton(
                  radius: 50, title: 'Get Started', onTap: onGetStarted),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnBaord1 extends StatelessWidget {
  const _OnBaord1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Image.asset(
              'assets/fashion.jpg',
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              'Welcome to Byat Test App tap,\n to continue',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
