import 'package:bayt_test_app/provider/locale_provider.dart';
import 'package:bayt_test_app/provider/search_provider.dart';
import 'package:bayt_test_app/ui/first_app/account/account.dart';
import 'package:bayt_test_app/ui/base_widiget/text_field.dart';
import 'package:bayt_test_app/ui/first_app/checkout/checkout.dart';
import 'package:bayt_test_app/ui/first_app/home/components/filter_sheet.dart';
import 'package:bayt_test_app/ui/first_app/home/home.dart';

import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class BottomNavigationUI extends StatefulWidget {
  const BottomNavigationUI({this.appBar, super.key});
  final PreferredSizeWidget? appBar;
  @override
  State<BottomNavigationUI> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigationUI> {
  int _selectedIndex = 0;
  final screens = const [
    HomeUI(),
    CheckoutUI(),
    AccountUI(),
  ];

  _onSelectNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  refreshState() => setState(() {});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(builder: (context, lang, child) {
      return Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onSelectNavigation,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home), label: 'home'.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.card_travel), label: 'checkout'.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person), label: 'account'.tr()),
          ],
        ),
      );
    });
  }
}
