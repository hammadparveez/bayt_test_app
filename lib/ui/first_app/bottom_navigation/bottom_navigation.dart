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
  State<BottomNavigationUI> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationUI> {
  int _selectedIndex = 0;
  late final SearchProvider _searchProvider;

  @override
  initState() {
    super.initState();

    _searchProvider = context.read<SearchProvider>();
    _searchProvider.searchController = TextEditingController();
    _searchProvider.searchFocusNode = FocusNode();
    _searchProvider.searchController!.addListener(_searchControllerListener);
    _searchProvider.searchFocusNode
        !.addListener(_searchProvider.saveSearchHistory);
  }

  _searchControllerListener() {
    _searchProvider.searchContentByName(_searchProvider.searchController!.text);
  }

  @override
  dispose() {
    _searchProvider.searchController!.removeListener(_searchControllerListener);
    _searchProvider.searchController!.dispose();
    _searchProvider.searchFocusNode!.dispose();
    super.dispose();
  }

  _onSelectNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PreferredSizeWidget _homeUIAppBar(BuildContext context) {
    return AppBar(
      title: ByatTextField(
        controller: context.read<SearchProvider>().searchController,
        focusNode: context.read<SearchProvider>().searchFocusNode,
        showBorder: false,
        suffixIconColor: Theme.of(context).colorScheme.onPrimary,
        textColor: Theme.of(context).colorScheme.onPrimary,
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        suffixIcon:
            Consumer<SearchProvider>(builder: (context, searchProvider, child) {
          final hasFocus = searchProvider.searchFocusNode!.hasFocus;
          return IconButton(
            color: ByatColors.white,
            icon: hasFocus ? const Icon(Icons.close) : const Icon(Icons.search),
            onPressed: () {
              if (hasFocus) {
                searchProvider.searchController!.clear();
              } else {
                searchProvider.searchFocusNode!.requestFocus();
              }
            },
          );
        }),
        // Icon(
        //     context.watch<SearchProvider>().searchFocusNode.hasFocus
        //         ? Icons.close
        //         : Icons.search,
        //     size: 26)),
      ),
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
    final screens = [
      HomeUI(),
      CheckoutUI(),
      AccountUI(),
    ];

    return Scaffold(
      appBar: _selectedIndex == 0 ? _homeUIAppBar(context) : null,
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
  }
}
