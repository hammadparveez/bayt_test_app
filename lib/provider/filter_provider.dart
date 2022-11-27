import 'package:bayt_test_app/main.dart';
import 'package:bayt_test_app/mock_data.dart';
import 'package:bayt_test_app/model/entity/user_model.dart';
import 'package:flutter/material.dart';
import 'package:bayt_test_app/util/extensions.dart';

enum OrderBy { ascending, descending }

enum OrderByDate { oldest, latest, random }

class FilterProvider extends ChangeNotifier {
  FilterProvider() {
    filterOnlyNationality();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    searchController
        .addListener(() => searchContentByName(searchController.text));
    searchFocusNode.addListener(_saveSearchHistory);
  }

  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;

  final nationality = <String>[];
  List<String> searchedHistory = [];
  final SEARCHED_HISTORY_KEY = 'search_history_key';
  final savedHistoryMaxLength = 12;
  List<UserModel> duplicatedData = userData;
  String selectedNationality = 'All';
  double startingDate = 0;
  double endingDate = 100;
  OrderBy orderedBy = OrderBy.ascending;
  OrderByDate selectedDateOrder = OrderByDate.random;

  @override
  void dispose() {
    debugPrint('FilterProvider Dispose');
    searchController.dispose();
    searchFocusNode.dispose();

    super.dispose();
  }

  _saveSearchHistory() {
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

  onSavedHistoryTap(String text) {
    searchController.text = text;
    searchFocusNode.unfocus();
    onApplyFilter();
  }

  clearSearchHistory() async {
    searchController.clear();
    await pref?.remove(SEARCHED_HISTORY_KEY);
    searchedHistory.clear();
    notifyListeners();
  }

  filterOnlyNationality() {
    for (var user in userData) {
      if (!nationality.contains(user.nationality)) {
        nationality.add(user.nationality);
      }
    }
    if (nationality.isNotEmpty) nationality.add('All');
  }

  onNationalitySelect(String? selectedItem) {
    if (selectedItem != null) {
      selectedNationality = selectedItem;
      notifyListeners();
    }
  }

  onDateOrderSelect(OrderByDate? item) {
    if (item != null) {
      selectedDateOrder = item;
      notifyListeners();
    }
  }

  sortDateOrder() {
    switch (selectedDateOrder) {
      case OrderByDate.latest:
        duplicatedData.sort((item1, item2) => item2.date.compareTo(item1.date));
        break;
      case OrderByDate.oldest:
        duplicatedData.sort((item1, item2) => item1.date.compareTo(item2.date));
        break;
      case OrderByDate.random:
        duplicatedData.shuffle();
        break;
    }
  }

  onResetFilter() {
    selectedDateOrder = OrderByDate.random;
    selectedNationality = 'All';
    duplicatedData = userData;
    notifyListeners();
  }

  onApplyFilter() {
    if (searchController.text.isNotEmpty) {
      searchContentByName(searchController.text);
    } else if (selectedNationality != 'All') {
      final filteredData = userData
          .where((item) => item.nationality == selectedNationality)
          .toList();
      duplicatedData = filteredData;
      sortDateOrder();
    } else {
      duplicatedData = userData;
      sortDateOrder();
    }

    notifyListeners();
  }

  void searchContentByName(String? name) {
    if (selectedNationality == 'All' &&
        selectedDateOrder == OrderByDate.random) {
      duplicatedData = userData
          .where((item) =>
              item.name.toLowerCase().contains((name?.toLowerCase()) ?? ''))
          .toList();
    } else {
      duplicatedData = userData.where((item) {
        bool containsName =
            item.name.toLowerCase().contains((name?.toLowerCase() ?? ''));
        bool constainsNationality = item.nationality == selectedNationality;

        if (containsName && constainsNationality) {
          return true;
        }
        return false;
      }).toList();
      sortDateOrder();
    }
    notifyListeners();
  }
}
