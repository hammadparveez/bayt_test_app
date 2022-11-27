import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:bayt_test_app/ui/account/account.dart';
import 'package:bayt_test_app/ui/base_widiget/text_field.dart';
import 'package:bayt_test_app/ui/checkout/checkout.dart';
import 'package:bayt_test_app/ui/home/components/filter_sheet.dart';
import 'package:bayt_test_app/ui/home/home.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class BottomNavigationUI extends StatefulWidget {
  const BottomNavigationUI({this.appBar, super.key});
  final PreferredSizeWidget? appBar;
  @override
  State<BottomNavigationUI> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationUI> {
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

  PreferredSizeWidget _homeUIAppBar() {
    return AppBar(
      title: ByatTextField(
          controller: context.read<FilterProvider>().searchController,
          focusNode: context.read<FilterProvider>().searchFocusNode,
          showBorder: false,
          suffixIcon:
              const Icon(Icons.search, size: 26, color: ByatColors.white)),
      actions: [
        IconButton(
            onPressed: () => showModalBottomSheet(
                context: context, builder: (_) => const FilterSheet()),
            icon: const Icon(Icons.filter_alt)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? _homeUIAppBar() : null,
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onSelectNavigation,
        selectedItemColor: Colors.purple,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: 'home'.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.card_travel), label: 'checkout'.tr()),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: 'account'.tr()),
        ],
      ),
    );
  }
}
