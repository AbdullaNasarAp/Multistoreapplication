import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/myprod/order/widget/delivered.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/myprod/order/widget/preparing.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/myprod/order/widget/shipping.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/button_container.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(title: "Order"),
          leading: const AppBarbackButton(),
          bottom: TabBar(
              indicatorColor: Colors.red.shade100,
              indicatorWeight: 5,
              tabs: const [
                RepeatedTab(label: "Preparing"),
                RepeatedTab(label: "Shipping"),
                RepeatedTab(label: "Delivered"),
              ]),
        ),
        body: const TabBarView(children: [
          Preparing(),
          Shipping(),
          Delivered(),
        ]),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  const RepeatedTab({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: TextTitle(
          title: label,
          ls: 0,
          fontwght: FontWeight.w500,
          fontsz: 17,
          color: xWhite,
        ),
      ),
    );
  }
}
