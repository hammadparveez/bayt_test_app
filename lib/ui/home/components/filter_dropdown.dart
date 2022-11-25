
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';

class FilterDropDown<T> extends StatelessWidget {
  const FilterDropDown(
      {Key? key,
      required this.value,
      required this.dropdownItems,
      this.upperCaseText = false,
      this.onDropdownSelect})
      : super(key: key);
  final T value;
  final List<T> dropdownItems;
  final bool upperCaseText;
  final Function(T?)? onDropdownSelect;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: value,
        underline: const SizedBox(),
        isExpanded: true,
        style: const TextStyle(color: Colors.white),
        dropdownColor: ByatColors.primary,
        items: dropdownItems
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                    upperCaseText ? e.toString().toUpperCase() : e.toString())))
            .toList(),
        onChanged: onDropdownSelect);
  }
}
