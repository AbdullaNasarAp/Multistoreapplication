import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/statics/widget.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/button_container.dart';

class Balance extends StatelessWidget {
  const Balance({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(title: "Balance"),
          leading: const AppBarbackButton(),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Material(
                  child: Center(child: CircularProgressIndicator()));
            }

            double totalPrice = 0.0;

            for (var item in snapshot.data!.docs) {
              totalPrice += item['orderqty'] * item['orderprice'];
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: StaticsWidget(
                    value0: "Total Out",
                    value1: totalPrice,
                    decimal: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {},
                    child: const ButtonContainer(
                        kWidth: double.infinity,
                        kHeight: 60,
                        kColors: xBlue,
                        title: "Get my money",
                        ls: 0,
                        fontwght: FontWeight.bold,
                        fontsz: 20,
                        bRadius: 20),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
