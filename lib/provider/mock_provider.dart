import 'package:bayt_test_app/mock_data.dart';
import 'package:flutter/material.dart';

class MockProvider extends ChangeNotifier {
  final nationality = <String>[];
  List<String> getNationality() {
    for (var user in userData) {
      if (!nationality.contains(user.nationality)) {
        nationality.add(user.nationality);
      }
    }
    return nationality;
  }
}
