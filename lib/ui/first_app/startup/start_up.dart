import 'package:bayt_test_app/ui/first_app/auth/login.dart';
import 'package:bayt_test_app/ui/first_app/on_board/on_board.dart';

import 'package:flutter/material.dart';

class StartUpUI extends StatefulWidget {
  const StartUpUI({super.key});

  @override
  State<StartUpUI> createState() => _StartUpUIState();
}

class _StartUpUIState extends State<StartUpUI> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  _onGetStarted() {
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 1500), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        OnBoard(onGetStarted: _onGetStarted),
        const LoginUI(),
      ],
    );
  }
}
