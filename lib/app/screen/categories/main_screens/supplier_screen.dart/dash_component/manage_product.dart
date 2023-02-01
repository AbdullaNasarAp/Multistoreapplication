import 'package:flutter/material.dart';
import 'package:siopa/app/widget/app_bar.dart';

class ManaageProduct extends StatelessWidget {
  const ManaageProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Manage Product"),
        leading: const AppBarbackButton(),
      ),
    );
  }
}
