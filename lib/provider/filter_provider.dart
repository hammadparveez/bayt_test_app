import 'package:bayt_test_app/mock_data.dart';
import 'package:bayt_test_app/model/entity/user_model.dart';
import 'package:flutter/material.dart';

enum OrderBy { ascending, descending }

enum OrderByDate { oldest, latest, random }

class FilterProvider extends ChangeNotifier {
  FilterProvider() {
    filterOnlyNationality();
  }
  final orderByDateText = ['Oldest', 'Latest', 'Random'];
  List<UserModel> duplicatedData = userData;
  final nationality = <String>[];
  String selectedNationality = 'All';
  double startingDate = 0;
  double endingDate = 100;
  OrderBy orderedBy = OrderBy.ascending;
  OrderByDate selectedDateOrder = OrderByDate.random;

  filterOnlyNationality() {
    for (var user in userData) {
      if (!nationality.contains(user.nationality)) {
        nationality.add(user.nationality);
      }
    }
    if (nationality.isNotEmpty) nationality.add('All');
  }

  sortDate() {
    duplicatedData.sort((model1, model2) => model1.date.compareTo(model2.date));
    startingDate = duplicatedData.first.date.millisecondsSinceEpoch.toDouble();
    endingDate = duplicatedData.last.date.millisecondsSinceEpoch.toDouble();
    notifyListeners();
  }

  void changeOrder(OrderBy? selectedOrder) {
    if (selectedOrder != orderedBy) {
      orderedBy = selectedOrder!;
      notifyListeners();
    }
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
    } else {
      duplicatedData = userData;
    }
    switch (orderedBy) {
      case OrderBy.ascending:
        duplicatedData.sort((item1, item2) => item1.name.compareTo(item2.name));
        break;
      case OrderBy.descending:
        duplicatedData.sort((item1, item2) => item2.name.compareTo(item1.name));
        break;
    }
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

    notifyListeners();
  }
}
