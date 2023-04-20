import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/widget/app_bar.dart';

import '../../../../../../widget/button_container.dart';

class AddressBook extends StatelessWidget {
  const AddressBook({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> addressStream = FirebaseFirestore.instance
        .collection('customers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('address')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Address Book",
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: addressStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Material(
                      child: Center(child: CircularProgressIndicator()));
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
                          title: "Ohh Category is Empty!!",
                          ls: 0,
                          fontwght: FontWeight.normal,
                          fontsz: 15,
                        )
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return const ListTile();
                  },
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
