import 'package:bayt_test_app/main.dart';
import 'package:bayt_test_app/mock_data.dart';
import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:bayt_test_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProvider extends ChangeNotifier {
  void searchContentByName(String? name) {
    final filterProvider =
        ByatRoute.navigatorKey.currentContext!.read<FilterProvider>();
    final temp = filterProvider.duplicatedData;
    debugPrint('temp: $temp');
    if (filterProvider.selectedNationality == 'All' &&
        filterProvider.selectedDateOrder == OrderByDate.random) {
      filterProvider.duplicatedData =
          userData.where((item) => item.name.contains(name ?? '')).toList();
    } else {
      filterProvider.duplicatedData = filterProvider.duplicatedData
          .where((item) => item.name.contains(name ?? ''))
          .toList();
    }
    notifyListeners();
  }
}
