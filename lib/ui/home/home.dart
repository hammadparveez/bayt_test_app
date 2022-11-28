import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:bayt_test_app/provider/search_provider.dart';
import 'package:bayt_test_app/ui/base_widiget/custom_badge.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Consumer2<FilterProvider, SearchProvider>(
                  builder: (context, filter, searchProvider, child) {
                return ListView.separated(
                    padding: const EdgeInsets.only(top: 20),
                    itemCount: filter.duplicatedData.length,
                    separatorBuilder: (_, index) => const Divider(),
                    itemBuilder: (_, index) {
                      final item = filter.duplicatedData[index];
                      final date = DateFormat.yMMMd().format(item.date);
                      return ListTile(
                        title: Text(item.name.toLowerCase().tr()),
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
              }),
            ),
          ],
        ),
        Consumer2<FilterProvider, SearchProvider>(
            builder: (context, filter, searchProvider, child) {
          if (searchProvider.searchFocusNode.hasFocus &&
              searchProvider.searchedHistory.isNotEmpty) {
            return Positioned(
                child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
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
                              onTap: () =>
                                  searchProvider.onSavedHistoryTagTap(e),
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
            ));
          }
          return const SizedBox();
        }),
      ],
    );
  }
}
