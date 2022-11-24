import 'package:bayt_test_app/mock_data.dart';
import 'package:bayt_test_app/provider/mock_provider.dart';
import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomeUI extends StatelessWidget {
  HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.only(top: 20),
                itemCount: userData.length,
                separatorBuilder: (_, index) => const Divider(),
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(userData[index].name),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Date: ${userData[index].date.toString()}'),
                        const SizedBox(width: 8),
                        Text('Nationality: ${userData[index].nationality}'),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

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
                  DropdownButton(
                      underline: const SizedBox(),
                      isExpanded: true,
                      style: const TextStyle(color: Colors.white),
                      dropdownColor: ByatColors.primary,
                      items: context
                          .watch<MockProvider>()
                          .getNationality()
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (_) {}),
                ],
              ),
            ),
            FilterCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sort by'),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          value: true,
                          groupValue: true,
                          onChanged: (_) {},
                          title: Text('Ascending'),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: true,
                          groupValue: true,
                          onChanged: (_) {},
                          title: Text(
                            'Descending',
                            style: TextStyle(color: ByatColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text('Date Range', style: TextStyle(fontSize: 18)),
            RangeSlider(
                min: 0,
                max: 100,
                values: RangeValues(50, 60),
                onChanged: (_) {}),
            ByatElevatedButton(
                title: 'Apply Filter', onTap: () {}, hasSuffixIcon: true),
          ],
        ),
      ),
    );
  }
}

class FilterCard extends StatelessWidget {
  const FilterCard({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DefaultTextStyle(
            style: const TextStyle(color: ByatColors.white), child: child),
      ),
    );
  }
}
