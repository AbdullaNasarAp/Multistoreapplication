import 'package:flutter/material.dart';
import 'package:siopa/widget/app_bar.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Stores"),
      ),
    );
  }
}
