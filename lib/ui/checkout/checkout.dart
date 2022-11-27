import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CheckoutUI extends StatelessWidget {
  const CheckoutUI({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: ByatColors.primary,
            child: const TabBar(tabs: [
              Tab(child: Text('Byat')),
              Tab(child: Text('Ryat')),
            ]),
          ),
          Expanded(
            child: TabBarView(children: [
              Center(child: Text('Byat')),
              Center(child: Text('Byat Test App')),
            ]),
          ),
        ],
      ),
    );
  }
}
