import 'package:bayt_test_app/domain/model/user_model.dart';
import 'package:bayt_test_app/mock_data.dart';
import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:bayt_test_app/provider/search_provider.dart';
import 'package:bayt_test_app/routes.dart';
import 'package:bayt_test_app/ui/base_widiget/custom_badge.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _UsersListViewWidget(),
        Consumer2<FilterProvider, SearchProvider>(
            builder: (context, filterProvider, searchProvider, child) {
          final hasFocus = searchProvider.searchFocusNode!.hasFocus;
          final isHistoryNotEmpty = searchProvider.searchedHistory.isNotEmpty;
          if (hasFocus && isHistoryNotEmpty) {
            return Positioned(
                child: _SearchTagWidget(
              filterProvider: filterProvider,
              searchProvider: searchProvider,
            ));
          }
          return const SizedBox();
        }),
      ],
    );
  }
}

class _UsersListViewWidget extends StatefulWidget {
  const _UsersListViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_UsersListViewWidget> createState() => _UsersListViewWidgetState();
}

class _UsersListViewWidgetState extends State<_UsersListViewWidget> {
  final PagingController<int, UserModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final isLastPage = userData.length < userData.length;
      if (isLastPage) {
        // _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 5;
        _pagingController.appendPage(userData, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<FilterProvider, SearchProvider>(
        builder: (context, filter, searchProvider, child) {
      return ListView.separated(
          padding: const EdgeInsets.only(top: 20),
          itemCount: filter.duplicatedData.length,
          separatorBuilder: (_, index) => const Divider(),
          itemBuilder: (_, index) {
            final user = filter.duplicatedData[index];
            final date = DateFormat.yMMMd().format(user.date);
            return ListTile(
              onTap: () {
                filter.onUserSelect(user);
                Navigator.pushNamed(context, ByatRoute.userDetail);
              },
              title: Text(user.name.toLowerCase().tr()),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Date: $date'),
                  const SizedBox(width: 8),
                  Text(
                      'Nationality: ${filter.duplicatedData[index].nationality}'),
                ],
              ),
            );
          });
    });
  }
}

class _SearchTagWidget extends StatelessWidget {
  const _SearchTagWidget({
    Key? key,
    required this.filterProvider,
    required this.searchProvider,
  }) : super(key: key);
  final FilterProvider filterProvider;
  final SearchProvider searchProvider;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          color: Color(0xFFE9E8E8)),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: searchProvider.searchedHistory
                .map((e) => CustomBadge(
                      title: e,
                      onTap: () => searchProvider.onSavedHistoryTagTap(e),
                    ))
                .toList(),
          ),
          const Divider(),
          Align(
              alignment: Alignment.bottomRight,
              child: CustomBadge(
                title: 'Clear history',
                onTap: searchProvider.clearSearchHistory,
                backgroundColor: ByatColors.ligtGrey,
                titleColor: ByatColors.black,
              )),
        ],
      ),
    );
  }
}
