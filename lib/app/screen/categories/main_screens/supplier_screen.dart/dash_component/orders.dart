import 'package:flutter/material.dart';
import 'package:siopa/app/widget/app_bar.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Order"),
        leading: const AppBarbackButton(),
      ),
    );
  }
}
