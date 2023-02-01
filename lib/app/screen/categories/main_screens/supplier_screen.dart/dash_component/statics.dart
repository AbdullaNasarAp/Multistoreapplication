import 'package:flutter/material.dart';
import 'package:siopa/app/widget/app_bar.dart';

class Statics extends StatelessWidget {
  const Statics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Statics"),
        leading: const AppBarbackButton(),
      ),
    );
  }
}
