import 'package:bayt_test_app/mock_data.dart';
import 'package:flutter/material.dart';

enum OrderBy { ascending, descending }

enum OrderByDate { oldest, latest, random }

class FilterProvider extends ChangeNotifier {
  FilterProvider() {
    filterOnlyNationality();
    sortDate();
  }
  final orderByDateText = ['Oldest', 'Latest', 'Random'];
  final duplicatedData = userData;
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
    sortDate();
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
}
