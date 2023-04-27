import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/address.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/profile/widget/add_address.dart';
import 'package:siopa/app/utils/colors.dart';
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
                            title: "You don't set an address yet!",
                            ls: 0,
                            color: xBlack,
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
                      var costumerAddress = snapshot.data!.docs[index];
                      var snap = snapshot.data!.docs;
                      return AddressTile(
                        costumerAddress: costumerAddress,
                        snap: snap,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                height: 50,
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(15),
                  fillColor: xBlue,
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAddress(),
                        ));
                  },
                  child: const TextTitle(
                      title: "Add Address",
                      ls: 0,
                      color: xWhite,
                      fontwght: FontWeight.normal,
                      fontsz: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  const AddressTile({
    super.key,
    required this.costumerAddress,
    required this.snap,
  });

  final QueryDocumentSnapshot<Object?> costumerAddress;
  final List<QueryDocumentSnapshot<Object?>> snap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AddressProvider>(
        builder: (context, aP, child) {
          return Dismissible(
            onDismissed: (direction) async {
              return aP.deleteAddress(costumerAddress);
            },
            key: UniqueKey(),
            child: InkWell(
              onTap: () async {
                aP.setDefaultAddress(snap, costumerAddress, context);
              },
              child: Card(
                color:
                    costumerAddress['default'] == true ? xBlue : xred.shade100,
                child: ListTile(
                  trailing: costumerAddress['default'] == true
                      ? const Icon(
                          Icons.home,
                          color: xWhite,
                        )
                      : const SizedBox(),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextTitle(
                            title:
                                "Name: ${costumerAddress['firstname']} ${costumerAddress['lastname']}",
                            ls: 0,
                            color: costumerAddress['default'] == true
                                ? xWhite
                                : xBlack87,
                            fontwght: FontWeight.normal,
                            fontsz: 14),
                        TextTitle(
                            title: "Phone: ${costumerAddress['phone']} ",
                            ls: 0,
                            color: costumerAddress['default'] == true
                                ? xWhite
                                : xBlack87,
                            fontwght: FontWeight.normal,
                            fontsz: 14),
                        TextTitle(
                            title:
                                "Street  ${costumerAddress['street']}               ",
                            ls: 0,
                            color: costumerAddress['default'] == true
                                ? xWhite
                                : xBlack87,
                            fontwght: FontWeight.normal,
                            fontsz: 13),
                        TextTitle(
                            title: "Pincode: s${costumerAddress['pincode']}",
                            ls: 0,
                            color: costumerAddress['default'] == true
                                ? xWhite
                                : xBlack87,
                            fontwght: FontWeight.normal,
                            fontsz: 13),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTitle(
                                title: "City: ${costumerAddress['city']},",
                                ls: 0,
                                color: costumerAddress['default'] == true
                                    ? xWhite
                                    : xBlack87,
                                fontwght: FontWeight.normal,
                                fontsz: 13),
                            TextTitle(
                                title: "State: ${costumerAddress['state']},",
                                ls: 0,
                                color: costumerAddress['default'] == true
                                    ? xWhite
                                    : xBlack87,
                                fontwght: FontWeight.normal,
                                fontsz: 13),
                            TextTitle(
                                title: "Country: ${costumerAddress['country']}",
                                ls: 0,
                                color: costumerAddress['default'] == true
                                    ? xWhite
                                    : xBlack87,
                                fontwght: FontWeight.normal,
                                fontsz: 13)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
