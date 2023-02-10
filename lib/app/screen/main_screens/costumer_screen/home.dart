import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/myprod/widgets/bags_gallery.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/myprod/widgets/beauty_gallery.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/myprod/widgets/electronics_gallery.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/myprod/widgets/home_garden_gallery.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/myprod/widgets/women_gallery.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/fakesearch.dart';

import '../supplier_screen.dart/dash_component/myprod/widgets/accessories_gallery.dart';
import '../supplier_screen.dart/dash_component/myprod/widgets/kids_gallery.dart';
import '../supplier_screen.dart/dash_component/myprod/widgets/men_gallery.dart';
import '../supplier_screen.dart/dash_component/myprod/widgets/shoe_gallery.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: xWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: xBlue,
          title: const FakeSearch(),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.red.shade100,
            indicatorWeight: 5,
            tabs: const [
              HomeTab(title: "Men"),
              HomeTab(title: "Women"),
              HomeTab(title: "Shoes"),
              HomeTab(title: "Bags"),
              HomeTab(title: "Electronics"),
              HomeTab(title: "Accessories"),
              HomeTab(title: "Home & Garden"),
              HomeTab(title: "Kids"),
              HomeTab(title: "Beauty"),
            ],
          ),
        ),
        body: Container(
          color: xWhite,
          child: const TabBarView(children: [
            MenGallery(),
            WomenGallery(),
            ShoesGallery(),
            BagsGallery(),
            ElectronicsGallery(),
            AccessoriesGallery(),
            HomeandGardenGallery(),
            KidsGallery(),
            BeautyGallery(),
          ]),
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: const TextStyle(color: xWhite),
      ),
    );
  }
}
