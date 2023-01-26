import 'package:flutter/material.dart';
import 'package:siopa/utils/colors.dart';
import 'package:siopa/widget/fakesearch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: xBlack87,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: xBlack87,
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
          color: xBlack87,
          child: const TabBarView(children: [
            Center(child: Text("Men Screen")),
            Center(child: Text("Women Screen")),
            Center(child: Text("Shoe Screen")),
            Center(child: Text("Bags Screen")),
            Center(child: Text("Electronics Screen")),
            Center(child: Text("Accessories Screen")),
            Center(child: Text("Home & Garden Screen")),
            Center(child: Text("Kids Screen")),
            Center(child: Text("Beauty Screen")),
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
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
