import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/myprod/order/widget/supplier_order_model.dart';
import 'package:siopa/app/widget/button_container.dart';

class Preparing extends StatelessWidget {
  const Preparing({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('deliverystatus', isEqualTo: 'preparing')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/inapp/empty.png",
                  height: 250,
                  width: 250,
                ),
                const TextTitle(
                  title: "You have not Active Orders!!",
                  ls: 0,
                  fontwght: FontWeight.normal,
                  fontsz: 15,
                )
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return SupplierOrder(
              order: snapshot.data!.docs[index],
            );
          },
        );
      },
    );
  }
}
