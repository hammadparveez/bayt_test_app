import 'package:bayt_test_app/mock_data.dart';
import 'package:bayt_test_app/provider/filter_provider.dart';
import 'package:bayt_test_app/ui/base_widiget/custom_radio_button.dart';
import 'package:bayt_test_app/ui/base_widiget/elevated_button.dart';
import 'package:bayt_test_app/ui/home/components/filter_card.dart';
import 'package:bayt_test_app/ui/home/components/filter_sheet.dart';
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
        title: TextField(),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
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
