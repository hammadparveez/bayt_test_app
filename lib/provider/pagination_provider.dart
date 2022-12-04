import 'package:bayt_test_app/domain/model/user_model.dart';
import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef PagingCallBack<T> = void Function(T pageKey);

class PaginationProvider extends ChangeNotifier {
  PaginationProvider(FilterProvider? filter) : _filter = filter;

  FilterProvider? _filter;
  // PagingController<PageKeyType, ItemType>? controller;

  int numberOfItems = 5;
  int _fetchedItemsIndex = 0;
  void update(FilterProvider provider) => _filter = provider;
  // void initController(PagingController<PageKeyType, ItemType> pageController) =>
  //     controller = pageController;
  // disposeController() => controller?.dispose();
  // void attachPaginationListener(PagingCallBack callback) {
  //   controller?.addPageRequestListener(callback);
  // }

  
}
