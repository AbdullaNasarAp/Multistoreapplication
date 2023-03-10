import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/controller/costumer_control/payment.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/button_container.dart';
import 'package:siopa/app/widget/payment_radio.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final totalPrice = context.watch<CartProvider>().totalPrice;
    final totalPaid = context.watch<CartProvider>().totalPrice + 10.0;

    CollectionReference customers =
        FirebaseFirestore.instance.collection('customers');

    return FutureBuilder<DocumentSnapshot>(
        future: customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Material(
              child: Scaffold(
                  appBar: AppBar(
                    leading: const AppBarbackButton(),
                    automaticallyImplyLeading: false,
                    title: const TextTitle(
                        title: "Payment",
                        ls: 0,
                        fontwght: FontWeight.bold,
                        fontsz: 18),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 70),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextTitle(
                                        title: "Total",
                                        ls: 0,
                                        fontwght: FontWeight.w600,
                                        fontsz: 20,
                                      ),
                                      TextTitle(
                                        title:
                                            "₹ ${totalPaid.toStringAsFixed(1)}",
                                        ls: 0,
                                        fontwght: FontWeight.w600,
                                        fontsz: 20,
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextTitle(
                                        title: "Order Total",
                                        ls: 0,
                                        fontwght: FontWeight.w600,
                                        fontsz: 17,
                                        color: xGrey,
                                      ),
                                      TextTitle(
                                        title:
                                            "₹ ${totalPrice.toStringAsFixed(1)}",
                                        ls: 0,
                                        fontwght: FontWeight.w600,
                                        fontsz: 17,
                                        color: xGrey,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      TextTitle(
                                        title: "Shipping Coast",
                                        ls: 0,
                                        fontwght: FontWeight.w600,
                                        fontsz: 17,
                                        color: xGrey,
                                      ),
                                      TextTitle(
                                        title: "₹ 10.0",
                                        ls: 0,
                                        fontwght: FontWeight.w600,
                                        fontsz: 17,
                                        color: xGrey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 450,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(20)),
                            child: Consumer<PaymentProvider>(
                              builder: (context, payment, child) {
                                return Column(
                                  children: [
                                    RadiolistTile(
                                        title: "Cash on Delivery",
                                        widget: const Text("Pay cash at home"),
                                        groupValue: payment.selectedValue,
                                        value: 1,
                                        onchanged: (value) {
                                          payment.selectValue(value);
                                        }),
                                    RadiolistTile(
                                        title: "Pay via Visa / MasterCard",
                                        widget: Row(
                                          children: const [
                                            FaIcon(FontAwesomeIcons.creditCard),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            FaIcon(
                                                FontAwesomeIcons.ccMastercard),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            FaIcon(FontAwesomeIcons.ccVisa)
                                          ],
                                        ),
                                        groupValue: payment.selectedValue,
                                        value: 2,
                                        onchanged: (value) {
                                          payment.selectValue(value);
                                        }),
                                    RadiolistTile(
                                        title: "Pay via PayPal",
                                        widget: Row(
                                          children: const [
                                            FaIcon(FontAwesomeIcons.paypal),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            FaIcon(FontAwesomeIcons.ccPaypal)
                                          ],
                                        ),
                                        groupValue: payment.selectedValue,
                                        value: 3,
                                        onchanged: (value) {
                                          payment.selectValue(value);
                                        })
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  bottomSheet: Consumer<PaymentProvider>(
                    builder: (context, value, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: () {
                              if (value.selectedValue == 1) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const TextTitle(
                                            title: "Cash on Delivery",
                                            ls: 0,
                                            fontwght: FontWeight.bold,
                                            fontsz: 20,
                                          ),
                                          TextTitle(
                                            title:
                                                "₹ ${totalPaid.toStringAsFixed(1)}",
                                            ls: 0,
                                            fontwght: FontWeight.bold,
                                            fontsz: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () async {
                                                value.showProgress(context);
                                                value.paymentSuccess(
                                                    snapshot, context);
                                              },
                                              child: const ButtonContainer(
                                                  kWidth: double.maxFinite,
                                                  kHeight: 50,
                                                  kColors: xBlue,
                                                  title: "Confirm",
                                                  ls: 0,
                                                  fontwght: FontWeight.w600,
                                                  fontsz: 20,
                                                  bRadius: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else if (value.selectedValue == 2) {
                                int payment = totalPaid.round();
                                int pay = payment * 100;

                                value.makePayment(
                                    snapshot.data, context, pay.toString());
                              } else if (value.selectedValue == 3) {
                                log("paypal");
                              }
                            },
                            child: ButtonContainer(
                                kWidth: double.infinity,
                                kHeight: 50,
                                kColors: xBlue,
                                title:
                                    "Cofirm  ₹ ${totalPaid.toStringAsFixed(1)}",
                                ls: 0,
                                fontwght: FontWeight.w500,
                                fontsz: 17,
                                bRadius: 10),
                          ),
                        ),
                      );
                    },
                  )),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
