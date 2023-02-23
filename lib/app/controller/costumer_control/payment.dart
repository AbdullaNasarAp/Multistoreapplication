// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/bottum_nav.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class PaymentProvider with ChangeNotifier {
  int selectedValue = 1;
  late String orderId;

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
        builder: (context) => CostumerHomeScreen(),
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
}
