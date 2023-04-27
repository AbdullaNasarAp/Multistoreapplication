import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/address.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/loginscreen.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/profile/widget/address_list.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/profile/widget/alert.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/profile/widget/cart_order_wish.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/profile/widget/prof_widget.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/profile/widget/sliver_costum_app_bar.dart';
import 'package:siopa/app/utils/colors.dart';
import '../../../../../widget/cpi.dart';
import 'widget/add_address.dart';

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
                    SliverCostumAppBar(data: data),
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
                                const ProfileHeader(
                                  title: "  Account Info  ",
                                ),
                                Consumer<AddressProvider>(
                                  builder: (context, aP, child) {
                                    return InfoCard(
                                      icondata1: Icons.email,
                                      title1: "Email Address",
                                      sub1: data['email'] == ''
                                          ? 'guest@guest.com'
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
                                      sub3: aP.userAddress(data),
                                      /*
                                     data['address'] == ''
                                        ? 'No Address'
                                        : data['address'],
                                    */

                                      ontap3: FirebaseAuth
                                              .instance.currentUser!.isAnonymous
                                          ? () {
                                              null;
                                            }
                                          : () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddressBook()));
                                            },
                                    );
                                  },
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

        return const CPI();
      },
    );
  }

  Future<dynamic> myAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Alert(
        onpress: () {
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
        title: "Logout",
        content: "Are you sure to logout ?",
      ),
    );
  }
}
