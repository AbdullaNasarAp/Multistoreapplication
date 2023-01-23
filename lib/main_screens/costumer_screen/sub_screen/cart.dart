import 'package:flutter/material.dart';
import 'package:siopa/widget/app_bar.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: "Cart"),
        leading: AppBarbackButton(),
      ),
    );
  }
}
