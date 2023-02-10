import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/supplier_control/category.dart';
import 'package:siopa/app/screen/categories/accessories.dart';
import 'package:siopa/app/screen/categories/bags.dart';
import 'package:siopa/app/screen/categories/beauty.dart';
import 'package:siopa/app/screen/categories/electronics.dart';
import 'package:siopa/app/screen/categories/home_garden.dart';
import 'package:siopa/app/screen/categories/kids.dart';
import 'package:siopa/app/screen/categories/men.dart';
import 'package:siopa/app/screen/categories/shoe.dart';
import 'package:siopa/app/screen/categories/women.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/fakesearch.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoryProvider>(context, listen: false).initValueGetting();
    });
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: xWhite,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: xBlue,
        elevation: 0,
        title: const FakeSearch(),
      ),
      body: Stack(
        children: [
          Positioned(bottom: 0, left: 0, child: sideNav(size)),
          Positioned(bottom: 0, right: 0, child: categoryView(size))
        ],
      ),
    );
  }

  Widget sideNav(Size size) {
    return Consumer<CategoryProvider>(
      builder: (context, value, child) {
        return Container(
          height: size.height * 0.8,
          color: Colors.black12,
          width: size.width * 0.3,
          child: ListView.builder(
            itemCount: value.items.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  value.pageController.animateToPage(index,
                      duration: const Duration(seconds: 1),
                      curve: Curves.decelerate);
                },
                child: Container(
                  height: 100,
                  color: value.items[index].isSelected == true
                      ? xBlue
                      : Colors.black12,
                  child: Center(
                    child: Text(value.items[index].label),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget categoryView(Size size) {
    return Consumer<CategoryProvider>(
      builder: (context, values, child) {
        return Container(
          height: size.height * 0.8,
          color: xWhite,
          width: size.width * 0.7,
          child: PageView(
            controller: values.pageController,
            onPageChanged: (value) {
              values.changeItem(value);
            },
            scrollDirection: Axis.vertical,
            children: const [
              MenCategory(),
              WomenCategory(),
              ShoesCategory(),
              BagCategory(),
              ElectronicsCategory(),
              AccessoriesCategory(),
              HomeAndGardenCategory(),
              KidsCategory(),
              BeautyCategory(),
            ],
          ),
        );
      },
    );
  }
}

class ItemsData {
  final String label;
  bool isSelected;

  ItemsData({
    required this.label,
    this.isSelected = false,
  });
}
