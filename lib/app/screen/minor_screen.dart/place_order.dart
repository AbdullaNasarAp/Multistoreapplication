import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/screen/minor_screen.dart/payment_screen.dart';
import 'package:siopa/app/screen/minor_screen.dart/widget.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/button_container.dart';

import '../main_screens/costumer_screen/sub_screen/profile/widget/add_address.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final totalPrice = context.watch<CartProvider>().totalPrice;

    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('customers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('address')
        .where('default', isEqualTo: true)
        .limit(1)
        .snapshots();
    late String name;
    late String phone;
    late String address;

    return StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Material(
            child: Scaffold(
                appBar: AppBar(
                  leading: const AppBarbackButton(),
                  automaticallyImplyLeading: false,
                  title: const TextTitle(
                      title: "Place Order",
                      ls: 0,
                      fontwght: FontWeight.bold,
                      fontsz: 18),
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 70),
                  child: Column(
                    children: [
                      snapshot.data!.docs.isEmpty
                          ? const PlaceOrderEmptyAddressTile()
                          : Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  var costumerAddress =
                                      snapshot.data!.docs[index];
                                  name = costumerAddress['firstname'] +
                                      costumerAddress['lastname'];
                                  phone = costumerAddress['phone'];
                                  address =
                                      "Country : ${costumerAddress['country']}\nState : ${costumerAddress['state']}\nCity : ${costumerAddress['city']}\nStreet : ${costumerAddress['street']}";

                                  return PlaceOrderAddressTile(
                                      costumerAddress: costumerAddress);
                                },
                                itemCount: snapshot.data!.docs.length,
                              ),
                            ),
                      sizedBox30,
                      Container(
                        height: 380,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)),
                        child: Consumer<CartProvider>(
                          builder: (context, cart, child) {
                            return ListView.builder(
                              itemCount: cart.count,
                              itemBuilder: (context, index) {
                                final order = cart.getItems[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(width: 1)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          child: Image.network(
                                              order.imageUrl.first,
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: 100),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextTitle(
                                                    title: order.name,
                                                    ls: 0,
                                                    fontwght: FontWeight.w600,
                                                    mL: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontsz: 16),
                                                TextTitle(
                                                    title:
                                                        "₹${order.price.toStringAsFixed(1)}",
                                                    ls: 0,
                                                    fontwght: FontWeight.normal,
                                                    color: Colors.red,
                                                    mL: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontsz: 15),
                                                TextTitle(
                                                    title:
                                                        "x ${order.qty.toString()}",
                                                    ls: 0,
                                                    fontwght: FontWeight.normal,
                                                    color: Colors.red,
                                                    mL: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontsz: 15),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                bottomSheet: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: snapshot.data!.docs.isEmpty
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddAddress(),
                              ));
                            }
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PaymentScreen(
                                    name: name,
                                    phone: phone,
                                    address: address,
                                  ),
                                ),
                              );
                            },
                      child: ButtonContainer(
                          kWidth: double.infinity,
                          kHeight: 50,
                          kColors: xBlue,
                          title: snapshot.data!.docs.isEmpty
                              ? "Set Address"
                              : "Cofirm  ₹ ${totalPrice.toStringAsFixed(1)}",
                          ls: 0,
                          fontwght: FontWeight.w500,
                          fontsz: 17,
                          bRadius: 10),
                    ),
                  ),
                )),
          );
        });
  }
}
