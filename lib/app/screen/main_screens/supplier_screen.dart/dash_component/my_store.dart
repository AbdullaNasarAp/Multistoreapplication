import 'package:flutter/material.dart';
import 'package:siopa/app/widget/app_bar.dart';

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "My Store"),
        leading: const AppBarbackButton(),
      ),
    );
  }
}
