import 'package:flutter/material.dart';
import 'package:siopa/app/widget/app_bar.dart';

class Balance extends StatelessWidget {
  const Balance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Balance"),
        leading: const AppBarbackButton(),
      ),
    );
  }
}
