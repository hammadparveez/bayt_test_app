import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:bayt_test_app/ui/base_widiget/custom_radio_button.dart';
import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:bayt_test_app/ui/home/components/filter_card.dart';
import 'package:bayt_test_app/ui/home/components/filter_dropdown.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilterCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Filter By Nationality'),
                  Consumer<FilterProvider>(builder: (context, filter, child) {
                    return FilterDropDown(
                      value: filter.selectedNationality,
                      dropdownItems: filter.nationality,
                      onDropdownSelect: filter.onNationalitySelect,
                    );
                  }),
                ],
              ),
            ),
            // FilterCard(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text('Sort by'),
            //       Consumer<FilterProvider>(builder: (context, filter, child) {
            //         return Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             CustomRadioButton(
            //                 title: 'Ascending',
            //                 groupValue: filter.orderedBy,
            //                 selectedValue: OrderBy.ascending,
            //                 onSelect: filter.changeOrder),
            //             CustomRadioButton(
            //               title: 'Descending',
            //               groupValue: filter.orderedBy,
            //               selectedValue: OrderBy.descending,
            //               onSelect: filter.changeOrder,
            //             ),
            //           ],
            //         );
            //       }),
            //     ],
            //   ),
            // ),

            FilterCard(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date Range', style: TextStyle(fontSize: 18)),
                Consumer<FilterProvider>(builder: (context, filter, child) {
                  return DropdownButton(
                      value: filter.selectedDateOrder,
                      underline: const SizedBox(),
                      isExpanded: true,
                      style: const TextStyle(color: Colors.white),
                      dropdownColor: ByatColors.primary,
                      items: OrderByDate.values
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.name.toUpperCase())))
                          .toList(),
                      onChanged: filter.onDateOrderSelect);
                }),
              ],
            )),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ByatElevatedButton(
                    backgroundColor: ByatColors.darkGrey,
                    title: 'Reset',
                    onTap: () {
                      context.read<FilterProvider>().onResetFilter();
                      
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ByatElevatedButton(
                    title: 'Apply Filter',
                    onTap: () {
                      context.read<FilterProvider>().onApplyFilter();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
