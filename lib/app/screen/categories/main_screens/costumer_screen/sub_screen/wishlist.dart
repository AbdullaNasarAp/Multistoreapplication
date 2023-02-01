import 'package:flutter/material.dart';
import 'package:siopa/app/widget/app_bar.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Wishlist"),
        leading: const AppBarbackButton(),
      ),
    );
  }
}
