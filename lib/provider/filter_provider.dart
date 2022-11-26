import 'package:bayt_test_app/main.dart';
import 'package:bayt_test_app/mock_data.dart';
import 'package:bayt_test_app/model/entity/user_model.dart';
import 'package:flutter/material.dart';

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
      debugPrint('Focus Lost');
      if (pref != null) {
        if (searchController.text.isNotEmpty &&
            history.length < savedHistoryMaxLength) {
          if (!history.contains(searchController.text)) {
            history.add(searchController.text);
            pref!.setStringList(SEARCHED_HISTORY_KEY, history);
          }
        }
        debugPrint('History $history');
      }
    }
    searchedHistory = history;
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
    } else {
      duplicatedData = userData;
    }

    notifyListeners();
  }

  void searchContentByName(String? name) {
    if (selectedNationality == 'All' &&
        selectedDateOrder == OrderByDate.random) {
      duplicatedData =
          userData.where((item) => item.name.contains(name ?? '')).toList();
    } else {
      duplicatedData = userData.where((item) {
        bool containsName = item.name.contains(name ?? '');
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
