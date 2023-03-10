import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/colors.dart';
import '../../widget/button_container.dart';

class OrderProvider with ChangeNotifier {
  double? rate;
  String? comment;

  void reviewAdding(dynamic order, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: xWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                maxRating: 5,
                glow: true,
                allowHalfRating: true,
                glowColor: xBlue,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: (value) {
                  rate = value;
                },
              ),
              sizedBox30,
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter you review",
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: xGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: xred,
                      ),
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    comment = value;
                  },
                ),
              ),
              sizedBox30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const TextTitle(
                          title: "Cancel",
                          ls: 0,
                          fontwght: FontWeight.bold,
                          fontsz: 16)),
                  OutlinedButton(
                      onPressed: () async {
                        CollectionReference collRef = FirebaseFirestore.instance
                            .collection('products')
                            .doc(order['prodid'])
                            .collection('reviews');

                        await collRef
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          "name": order['custname'],
                          "email": order['email'],
                          "rate": rate,
                          "comment": comment,
                        }).whenComplete(() async {
                          await FirebaseFirestore.instance
                              .runTransaction((transaction) async {
                            DocumentReference dRef = FirebaseFirestore.instance
                                .collection('orders')
                                .doc(order['orderid']);

                            await transaction
                                .update(dRef, {'orderreview': true});
                          });
                        });
                        await Future.delayed(const Duration(microseconds: 100))
                            .whenComplete(() {
                          Navigator.of(context).pop();
                        });
                      },
                      child: const TextTitle(
                          title: "Ok",
                          ls: 0,
                          fontwght: FontWeight.bold,
                          fontsz: 16))
                ],
              )
            ],
          ),
        );
      },
    );
    notifyListeners();
  }
}
