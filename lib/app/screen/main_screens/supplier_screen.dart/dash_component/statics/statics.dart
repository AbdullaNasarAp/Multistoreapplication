import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/statics/widget.dart';
import 'package:siopa/app/widget/app_bar.dart';

class Statics extends StatelessWidget {
  const Statics({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(title: "Statics"),
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

            num itemCount = 0;
            double totalPrice = 0.0;

            for (var item in snapshot.data!.docs) {
              itemCount += item['orderqty'];
            }

            for (var item in snapshot.data!.docs) {
              totalPrice += item['orderqty'] * item['orderprice'];
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  StaticsWidget(
                    value0: "Sold Out",
                    value1: snapshot.data!.docs.length,
                    decimal: 0,
                  ),
                  StaticsWidget(
                    value0: "Item Count",
                    value1: itemCount,
                    decimal: 0,
                  ),
                  StaticsWidget(
                    value0: "Total Out",
                    value1: totalPrice,
                    decimal: 2,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
