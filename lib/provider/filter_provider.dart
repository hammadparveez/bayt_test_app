import 'package:bayt_test_app/mock_data.dart';
import 'package:bayt_test_app/domain/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

enum OrderBy { ascending, descending }

enum OrderByDate { oldest, latest, random }

class FilterProvider extends ChangeNotifier {
  FilterProvider() {
    filterOnlyNationality();
  }
  // SearchProvider? searchProvider;

  final nationality = <String>[];
  UserModel? selectedUserModel;
  List<UserModel> duplicatedData = userData;
  String selectedNationality = 'All';
  double startingDate = 0;
  double endingDate = 100;
  OrderBy orderedBy = OrderBy.ascending;
  OrderByDate selectedDateOrder = OrderByDate.random;

  // void update(SearchProvider provider) => searchProvider = provider;
  onUserSelect(UserModel user) {
    selectedUserModel = user;
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

  onDateRangeSelect(DateTimeRange range, List<UserModel> sortedData) {
    final items = sortedData.where((element) {
      final isStartDateSame = element.date.isAtSameMomentAs(range.start);
      final isEndDateSame = element.date.isAtSameMomentAs(range.end);
      final isDateBefore = element.date.isBefore(range.end);
      final isDateAfter = element.date.isAfter(range.start);
      if ((isStartDateSame || isDateAfter) && (isDateBefore || isEndDateSame)) {
        return true;
      }

      return false;
    }).toList();
    duplicatedData = items;
    notifyListeners();
  }

  onResetFilter() {
    selectedDateOrder = OrderByDate.random;
    selectedNationality = 'All';
    duplicatedData = userData;
    notifyListeners();
  }

  onApplyFilter() {
    if (selectedNationality != 'All') {
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

  List<UserModel> getRangeOfData(int start, int end) =>
      duplicatedData.getRange(start, end).toList();
}
