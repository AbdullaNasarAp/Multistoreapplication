import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/loginscreen.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/cart.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/order/order.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/profile/widget/cart_order_wish.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/profile/widget/prof_widget.dart';
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
                          const CartOrderWish(),
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
                                  ontap1: () {},
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
