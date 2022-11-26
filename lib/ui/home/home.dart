import 'package:bayt_test_app/provider/filter_provider.dart';

import 'package:bayt_test_app/ui/base_widiget/text_field.dart';

import 'package:bayt_test_app/ui/home/components/filter_sheet.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ByatTextField(
            controller: context.read<FilterProvider>().searchController,
            focusNode: context.read<FilterProvider>().searchFocusNode,
            showBorder: false,
            suffixIcon:
                const Icon(Icons.search, size: 26, color: ByatColors.white)),
        actions: [
          IconButton(
              onPressed: () => showModalBottomSheet(
                  context: context, builder: (_) => const FilterSheet()),
              icon: Icon(Icons.filter_alt))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_travel), label: 'Checkout'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child:
                    Consumer<FilterProvider>(builder: (context, filter, child) {
                  return ListView.separated(
                      padding: const EdgeInsets.only(top: 20),
                      itemCount: filter.duplicatedData.length,
                      separatorBuilder: (_, index) => const Divider(),
                      itemBuilder: (_, index) {
                        final date = DateFormat.yMMMd()
                            .format(filter.duplicatedData[index].date);
                        return ListTile(
                          title: Text(filter.duplicatedData[index].name),
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
          if (context.watch<FilterProvider>().searchFocusNode.hasFocus)
            Positioned(
                child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: ByatColors.ligtGrey),
              width: double.infinity,
              child: Wrap(
                children: context
                    .watch<FilterProvider>()
                    .searchedHistory
                    .map((e) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          margin: const EdgeInsets.only(right: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: ByatColors.primary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            e,
                            style: const TextStyle(color: ByatColors.white),
                          ),
                        ))
                    .toList(),
              ),
            ))
        ],
      ),
    );
  }
}
