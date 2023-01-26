import 'package:flutter/material.dart';
import 'package:siopa/categories/accessories.dart';
import 'package:siopa/categories/bags.dart';
import 'package:siopa/categories/beauty.dart';
import 'package:siopa/categories/electronics.dart';
import 'package:siopa/categories/home_garden.dart';
import 'package:siopa/categories/kids.dart';
import 'package:siopa/categories/men.dart';
import 'package:siopa/categories/shoe.dart';
import 'package:siopa/categories/women.dart';
import 'package:siopa/utils/colors.dart';
import 'package:siopa/widget/fakesearch.dart';

List<ItemsData> items = [
  ItemsData(label: "Men"),
  ItemsData(label: "Women"),
  ItemsData(label: "Shoes"),
  ItemsData(label: "Bags"),
  ItemsData(label: "Electronics"),
  ItemsData(label: "Accessories"),
  ItemsData(label: "Home & Garden"),
  ItemsData(label: "Kids"),
  ItemsData(label: "Beauty"),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    for (var element in items) {
      element.isSelected = false;
    }
    setState(() {
      items[0].isSelected = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: xBlack87,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: xBlack87,
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
    return Container(
      height: size.height * 0.8,
      color: xBlack87,
      width: size.width * 0.3,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _pageController.animateToPage(index,
                  duration: const Duration(seconds: 1),
                  curve: Curves.decelerate);
            },
            child: Container(
              height: 100,
              color: items[index].isSelected == true ? xBlue : xBlack,
              child: Center(
                child: Text(items[index].label),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget categoryView(Size size) {
    return Container(
      height: size.height * 0.8,
      color: xBlack87,
      width: size.width * 0.7,
      child: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          for (var element in items) {
            element.isSelected = false;
          }
          setState(() {
            items[value].isSelected = true;
          });
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
