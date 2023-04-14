// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/controller/stripe_id.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/bottum_nav.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class PaymentProvider with ChangeNotifier {
  int selectedValue = 1;
  late String orderId;
  Map<String, dynamic>? paymentIntentData;

  void selectValue(int? value) {
    selectedValue = value!;
    notifyListeners();
  }

  void paymentSuccess(AsyncSnapshot snapshot, BuildContext context) async {
    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
    for (var item in context.read<CartProvider>().getItems) {
      CollectionReference orderRef =
          FirebaseFirestore.instance.collection("orders");
      orderId = const Uuid().v4();
      await orderRef.doc(orderId).set({
        'cid': data['cid'],
        'custname': data['name'],
        'email': data['email'],
        'address': data['address'],
        'phone': data['phone'],
        'sid': item.suppId,
        'prodid': item.documentId,
        'prodname': item.name,
        'orderid': orderId,
        'orderimage': item.imageUrl.first,
        'orderqty': item.qty,
        'orderprice': item.qty * item.price,
        'deliverystatus': 'preparing',
        'deliverydate': '',
        'orderdate': DateTime.now(),
        'paymentstatus': 'cash on delivery',
        'orderreview': false,
      }).whenComplete(() async {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentReference documentReference = FirebaseFirestore.instance
              .collection('products')
              .doc(item.documentId);
          DocumentSnapshot snapshot2 = await transaction.get(documentReference);
          transaction.update(documentReference, {
            'instock': snapshot2['instock'] - item.qty,
          });
        });
      });
    }

    context.read<CartProvider>().clearItems();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const CostumerHomeScreen(),
      ),
      (route) => false,
    );

    notifyListeners();
  }

  void showProgress(BuildContext context) async {
    Lottie.network(
        "https://assets1.lottiefiles.com/packages/lf20_C51Bca6c0m.json",
        height: 200,
        width: 200,
        animate: true,
        fit: BoxFit.cover);
    ProgressDialog progressDialog = ProgressDialog(context: context);
    await progressDialog.show(
        max: 100, msg: "Please Wait ... ", progressBgColor: Colors.black);
  }

  void makePayment(dynamic data, BuildContext context, String total) async {
    // createPaymentIntnet

    paymentIntentData = await createPaymentIntnet(total, 'INR');
    // initPaymentSheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          applePay: true,
          googlePay: true,
          testEnv: true,
          merchantDisplayName: 'Nabeel',
          merchantCountryCode: 'in'),
    );
// displayPaymentSheet
    await displayPaymentSheet(data, context);
  }

  createPaymentIntnet(String total, String currency) async {
    Map<String, dynamic> body = {
      'amount': total,
      'currency': currency,
      'payment_method_types[]': 'card',
    };

    var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'content_type': 'application/x-www-form-urlencoded'
        });
    return jsonDecode(response.body);
  }

  displayPaymentSheet(var data, BuildContext context) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((value) async {
        paymentIntentData = null;
        log("paid");
      });
      for (var item in context.read<CartProvider>().getItems) {
        CollectionReference orderRef =
            FirebaseFirestore.instance.collection("orders");
        orderId = const Uuid().v4();
        await orderRef.doc(orderId).set({
          'cid': data['cid'],
          'custname': data['name'],
          'email': data['email'],
          'address': data['address'],
          'phone': data['phone'],
          'sid': item.suppId,
          'prodid': item.documentId,
          'prodname': item.name,
          'orderid': orderId,
          'orderimage': item.imageUrl.first,
          'orderqty': item.qty,
          'orderprice': item.qty * item.price,
          'deliverystatus': 'preparing',
          'deliverydate': '',
          'orderdate': DateTime.now(),
          'paymentstatus': 'paid online',
          'orderreview': false,
        }).whenComplete(() async {
          await FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentReference documentReference = FirebaseFirestore.instance
                .collection('products')
                .doc(item.documentId);
            DocumentSnapshot snapshot2 =
                await transaction.get(documentReference);
            transaction.update(documentReference, {
              'instock': snapshot2['instock'] - item.qty,
            });
          });
        });
      }

      context.read<CartProvider>().clearItems();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const CostumerHomeScreen(),
        ),
        (route) => false,
      );

      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
