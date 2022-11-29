import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:bayt_test_app/provider/search_provider.dart';

import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:bayt_test_app/ui/first_app/home/components/filter_card.dart';
import 'package:bayt_test_app/ui/first_app/home/components/filter_dropdown.dart';

import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({super.key});

  _onFilterApply(BuildContext context) {
    final filterProvider = context.read<FilterProvider>();
    final searchProvider = context.read<SearchProvider>();

    if (searchProvider.searchController!.text.isNotEmpty) {
      searchProvider.searchContentByName(searchProvider.searchController!.text);
    } else {
      filterProvider.onApplyFilter();
    }
    Navigator.pop(context);
  }

  _onResetFilter(BuildContext context) {
    context.read<FilterProvider>().onResetFilter();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _filterByNationality(),
            _filterDateRange(),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ByatElevatedButton(
                    backgroundColor: ByatColors.darkGrey,
                    title: 'Reset',
                    onTap: () => _onResetFilter(context),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ByatElevatedButton(
                    title: 'Apply Filter',
                    onTap: () => _onFilterApply(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FilterCard _filterDateRange() {
    return FilterCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('date_range'.tr(), style: const TextStyle(fontSize: 18)),
        Consumer<FilterProvider>(builder: (context, filter, child) {
          return DropdownButton(
              value: filter.selectedDateOrder,
              underline: const SizedBox(),
              isExpanded: true,
              iconEnabledColor: Theme.of(context).brightness == Brightness.light
                  ? ByatColors.dropdownArrowColor
                  : null,
              dropdownColor: Theme.of(context).brightness == Brightness.light
                  ? ByatColors.primary
                  : ByatColors.dropdownColor,
              style: const TextStyle(color: Colors.white),
              items: OrderByDate.values
                  .map((e) => DropdownMenuItem(
                      value: e, child: Text(e.name.toUpperCase())))
                  .toList(),
              onChanged: filter.onDateOrderSelect);
        }),
      ],
    ));
  }

  FilterCard _filterByNationality() {
    return FilterCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('filter_by_nationality'.tr()),
          Consumer<FilterProvider>(builder: (context, filter, child) {
            return FilterDropDown(
              value: filter.selectedNationality,
              dropdownItems: filter.nationality,
              onDropdownSelect: filter.onNationalitySelect,
            );
          }),
        ],
      ),
    );
  }
}
