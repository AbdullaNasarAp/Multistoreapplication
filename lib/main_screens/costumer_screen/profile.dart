import 'package:flutter/material.dart';
import 'package:siopa/main_screens/costumer_screen/cart.dart';
import 'package:siopa/main_screens/costumer_screen/sub_screen/order.dart';
import 'package:siopa/main_screens/costumer_screen/sub_screen/wishlist.dart';
import 'package:siopa/utils/colors.dart';
import 'package:siopa/widget/app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: xBlack87,
      body: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(color: xBlack87),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                elevation: 0,
                backgroundColor: xBlack87,
                expandedHeight: 140,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        opacity: constraints.biggest.height <= 120 ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          "Accounts".toUpperCase(),
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: xWhite),
                        ),
                      ),
                      background: Container(
                        decoration: BoxDecoration(color: xBlack87),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 30),
                          child: Row(
                            children: [
                              Image.asset("images/inapp/guest.png"),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  "guest".toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 80,
                      decoration: BoxDecoration(
                        color: xBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 74,
                            width: MediaQuery.of(context).size.height * .15,
                            decoration: const BoxDecoration(
                              color: xBlack87,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      CartScreen(back: AppBarbackButton()),
                                ));
                              },
                              child: SizedBox(
                                height: 40,
                                width:
                                    MediaQuery.of(context).size.height * 0.12,
                                child: const Center(
                                    child: Text(
                                  "Cart",
                                  style: TextStyle(
                                      color: xWhite,
                                      fontSize: 22,
                                      fontFamily: "Poppins"),
                                )),
                              ),
                            ),
                          ),
                          Container(
                            height: 74,
                            width: MediaQuery.of(context).size.height * .15,
                            decoration: const BoxDecoration(
                              color: xBlack87,
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Order(),
                                ));
                              },
                              child: SizedBox(
                                height: 40,
                                width:
                                    MediaQuery.of(context).size.height * 0.12,
                                child: const Center(
                                    child: Text(
                                  "Order",
                                  style: TextStyle(
                                      color: xWhite,
                                      fontSize: 22,
                                      fontFamily: "Poppins"),
                                )),
                              ),
                            ),
                          ),
                          Container(
                            height: 74,
                            width: MediaQuery.of(context).size.height * .15,
                            decoration: const BoxDecoration(
                              color: xBlack87,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Wishlist(),
                                ));
                              },
                              child: SizedBox(
                                height: 40,
                                width:
                                    MediaQuery.of(context).size.height * 0.12,
                                child: const Center(
                                    child: Text(
                                  "Wishlist",
                                  style: TextStyle(
                                      color: xWhite,
                                      fontSize: 22,
                                      fontFamily: "Poppins"),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: xBlack87,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 150,
                            child: Image(
                              image: AssetImage(
                                "images/inapp/sample.webp",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const ProfileHeader(title: "  Account Info  "),
                          InfoCard(
                            icondata1: Icons.email,
                            title1: "Email Address",
                            sub1: "abd@gmail.com",
                            ontap1: () {},
                            title2: "Phone Number",
                            icondata2: Icons.phone,
                            sub2: "9078657654",
                            ontap2: () {},
                            title3: "Address",
                            icondata3: Icons.location_pin,
                            sub3: "New York 4 th Street",
                            ontap3: () {},
                          ),
                          const ProfileHeader(title: "  Account Settings  "),
                          InfoCard(
                            icondata1: Icons.edit,
                            title1: "Edit Profile",
                            ontap1: () {},
                            title2: "Change Password",
                            icondata2: Icons.security,
                            ontap2: () {},
                            title3: "Log Out",
                            icondata3: Icons.logout,
                            ontap3: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  InfoCard({
    Key? key,
    required this.title1,
    required this.title2,
    required this.title3,
    this.sub1,
    this.sub2,
    this.sub3,
    required this.icondata1,
    required this.icondata2,
    required this.icondata3,
    required this.ontap1,
    required this.ontap2,
    required this.ontap3,
  }) : super(key: key);
  final String title1;
  final String title2;
  final String title3;
  String? sub1;
  String? sub2;
  String? sub3;
  final IconData icondata1;
  final IconData icondata2;
  final IconData icondata3;
  final Function() ontap1;
  final Function() ontap2;
  final Function() ontap3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 260,
        decoration: BoxDecoration(
            color: xBlack87,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: xBlue, width: 2)),
        child: Column(
          children: [
            ProfileTile(
              title1: title1,
              sub1: sub1,
              icondata1: icondata1,
              function: () {
                ontap1;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                color: xBlue,
              ),
            ),
            ProfileTile(
              title1: title2,
              sub1: sub2,
              icondata1: icondata2,
              function: () {
                ontap2;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                color: Colors.blue.shade400,
              ),
            ),
            ProfileTile(
              title1: title3,
              sub1: sub3,
              icondata1: icondata3,
              function: () {
                ontap3;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key? key,
    required this.title1,
    required this.sub1,
    required this.icondata1,
    required this.function,
  }) : super(key: key);

  final String title1;
  final String? sub1;
  final IconData icondata1;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function;
      },
      title: Text(
        title1,
        style: TextStyle(color: xWhite),
      ),
      subtitle: Text(
        sub1 ?? '',
        style: TextStyle(color: xWhite),
      ),
      leading: Icon(
        icondata1,
        color: xWhite,
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
