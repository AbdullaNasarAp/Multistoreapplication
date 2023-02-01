import 'package:flutter/material.dart';
import 'package:siopa/app/widget/app_bar.dart';

class SubCategory extends StatelessWidget {
  const SubCategory({
    super.key,
    required this.subcategoryName,
    required this.mainCategory,
  });
  final String subcategoryName;
  final String mainCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: AppBarTitle(title: subcategoryName),
        leading: const AppBarbackButton(),
      ),
      body: Center(
        child: Text(mainCategory),
      ),
    );
  }
}
