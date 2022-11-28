import 'package:bayt_test_app/main.dart';
import 'package:bayt_test_app/mock_data.dart';
import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:bayt_test_app/util/extensions.dart';

class SearchProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  FilterProvider? filterProvider;
  final savedHistoryMaxLength = 12;
  List<String> searchedHistory = [];
  SearchProvider();

  void update(FilterProvider provider) => filterProvider = provider;
  void searchContentByName(String? name) {
    final filter = filterProvider!;
    if (filter.selectedNationality == 'All' &&
        filter.selectedDateOrder == OrderByDate.random) {
      filter.duplicatedData = userData
          .where((item) =>
              item.name.toLowerCase().contains((name?.toLowerCase()) ?? ''))
          .toList();
    } else {
      filter.duplicatedData = userData.where((item) {
        bool containsName =
            item.name.toLowerCase().contains((name?.toLowerCase() ?? ''));
        bool constainsNationality =
            item.nationality == filter.selectedNationality;

        if (containsName && constainsNationality) {
          return true;
        }
        return false;
      }).toList();
      filter.sortDateOrder();
    }
    notifyListeners();
  }

  saveSearchHistory() {
    final history = pref!.getStringList(SEARCHED_HISTORY_KEY) ?? [];
    if (!searchFocusNode.hasFocus) {
      if (pref != null) {
        final text = searchController.text.toLowerCase();
        if (text.length > 1 && history.length < savedHistoryMaxLength) {
          if (!history.contains(text)) {
            history.add(text);
            pref!.setStringList(SEARCHED_HISTORY_KEY, history);
          }
        }
      }
    }
    searchedHistory = history.modifyToCapitalize();
    notifyListeners();
  }

  onSavedHistoryTagTap(String text) {
    searchController.text = text;
    searchFocusNode.unfocus();
    filterProvider?.duplicatedData = filterProvider!.duplicatedData
        .where((item) => item.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
  }

  clearSearchHistory() async {
    searchController.clear();
    await pref?.remove(SEARCHED_HISTORY_KEY);
    searchedHistory.clear();
    notifyListeners();
  }
}
