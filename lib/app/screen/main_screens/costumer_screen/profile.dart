import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/loginscreen.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/cart.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/order.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/wishlist.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.docId});
  final String docId;

  @override
  Widget build(BuildContext context) {
    CollectionReference customers =
        FirebaseFirestore.instance.collection('customers');
    CollectionReference anounymous =
        FirebaseFirestore.instance.collection('anounymous');
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseAuth.instance.currentUser!.isAnonymous
          ? anounymous.doc(docId).get()
          : customers.doc(docId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: xWhite,
            body: Stack(
              children: [
                Container(
                  height: 244,
                  decoration: const BoxDecoration(color: xBlue),
                ),
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      backgroundColor: xBlue,
                      expandedHeight: 140,
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          return FlexibleSpaceBar(
                            title: AnimatedOpacity(
                              opacity:
                                  constraints.biggest.height <= 120 ? 1 : 0,
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
                              decoration: const BoxDecoration(color: xBlue),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25.0, left: 30),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 45,
                                      backgroundImage:
                                          AssetImage("images/inapp/guest.png"),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      child: Text(
                                        data['name'] == ''
                                            ? 'guest'.toUpperCase()
                                            : data['name'].toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: xWhite,
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
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.height * .13,
                                  decoration: const BoxDecoration(
                                    color: xBlack87,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => const CartScreen(
                                            back: AppBarbackButton()),
                                      ));
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      child: const Center(
                                          child: Text(
                                        "Cart",
                                        style: TextStyle(
                                            color: xWhite,
                                            fontSize: 17,
                                            fontFamily: "Poppins"),
                                      )),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.height * .13,
                                  decoration: const BoxDecoration(
                                    color: xBlack87,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const OrderScreen(),
                                      ));
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      child: const Center(
                                          child: Text(
                                        "Order",
                                        style: TextStyle(
                                            color: xWhite,
                                            fontSize: 17,
                                            fontFamily: "Poppins"),
                                      )),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.height * .13,
                                  decoration: const BoxDecoration(
                                    color: xBlack87,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => const Wishlist(),
                                      ));
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      child: const Center(
                                          child: Text(
                                        "Wishlist",
                                        style: TextStyle(
                                            color: xWhite,
                                            fontSize: 17,
                                            fontFamily: "Poppins"),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: xWhite,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 130,
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
                                  sub1: data['email'] == ''
                                      ? 'guest@example.com'
                                      : data['email'],
                                  ontap1: () {},
                                  title2: "Phone Number",
                                  icondata2: Icons.phone,
                                  sub2: data['phone'] == ''
                                      ? 'No Phone'
                                      : data['phone'],
                                  ontap2: () {},
                                  title3: "Address",
                                  icondata3: Icons.location_pin,
                                  sub3: data['address'] == ''
                                      ? 'No Address'
                                      : data['address'],
                                  ontap3: () {},
                                ),
                                const ProfileHeader(
                                    title: "  Account Settings  "),
                                InfoCard(
                                  icondata1: Icons.edit,
                                  title1: "Edit Profile",
                                  ontap1: () {
                                    log("dfdfdf");
                                  },
                                  title2: "Change Password",
                                  icondata2: Icons.security,
                                  ontap2: () {},
                                  title3: "Log Out",
                                  icondata3: Icons.logout,
                                  ontap3: () async {
                                    myAlert(context);
                                  },
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

        return Container(
          height: MediaQuery.of(context).size.height * 100,
          width: MediaQuery.of(context).size.width * 100,
          color: xBlack87,
          child: const Center(
            child: CircularProgressIndicator(
              color: xBlue,
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> myAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: xBlack,
        title: const Text(
          "Log out",
          style: TextStyle(color: xWhite),
        ),
        content: const Text(
          "Are you sure to log out",
          style: TextStyle(color: xWhite),
        ),
        actions: [
          OutlinedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(xBlue)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "No",
              style: TextStyle(color: xWhite),
            ),
          ),
          OutlinedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(xBlue)),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => CostumerLoginScreen(),
                ),
                (route) {
                  return false;
                },
              );
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: xWhite),
            ),
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
  final VoidCallback ontap1;
  final VoidCallback ontap2;
  final VoidCallback ontap3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 260,
        decoration: BoxDecoration(
            color: xWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: xBlue, width: 2)),
        child: Column(
          children: [
            ProfileTile(
                title1: title1,
                sub1: sub1,
                icondata1: icondata1,
                function: ontap1),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                color: xBlue,
              ),
            ),
            ProfileTile(
                title1: title2,
                sub1: sub2,
                icondata1: icondata2,
                function: ontap2),
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
                function: ontap3),
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
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: function,
      title: Text(
        title1,
        style: const TextStyle(color: xBlack87),
      ),
      subtitle: Text(
        sub1 ?? '',
        style: const TextStyle(color: xBlack87),
      ),
      leading: Icon(
        icondata1,
        color: xBlack87,
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
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 10,
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
