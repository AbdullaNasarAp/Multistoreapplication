import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:uuid/uuid.dart';

import '../../screen/main_screens/costumer_screen/auth/widgets.dart';

class AddressProvider with ChangeNotifier {
  String? countryValue = "Choose Country";
  String? stateValue = "Choose State";
  String? cityValue = "Choose City";
  String? firstName;
  String? lastName;
  String? phone;
  String? pincode;
  String? location;

  String userAddress(dynamic data) {
    if (FirebaseAuth.instance.currentUser!.isAnonymous == true) {
      return "example: Kallery House Kunhome";
    } else if (FirebaseAuth.instance.currentUser!.isAnonymous == false &&
        data['address'] == '') {
      return "Set your Address";
    }
    return data['address'];
  }

  countrySelection(String value) {
    countryValue = value;
    notifyListeners();
  }

  stateSelection(String value) {
    stateValue = value;
    notifyListeners();
  }

  citySelection(String value) {
    cityValue = value;
    notifyListeners();
  }

  void addAddress(
    BuildContext context,
    dynamic formKey,
    dynamic scaffoldKey,
  ) async {
    if (formKey.currentState!.validate()) {
      if (countryValue != "Choose Country" &&
          stateValue != "Choose State" &&
          cityValue != "Choose City") {
        formKey.currentState!.save();
        CollectionReference addressRef = FirebaseFirestore.instance
            .collection('customers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('address');
        var addressId = const Uuid().v4();
        await addressRef.doc(addressId).set({
          'addressId': addressId,
          'firstname': firstName,
          'lastname': lastName,
          'phone': phone,
          'street': location,
          'pincode': pincode,
          'country': countryValue,
          'state': stateValue,
          'city': cityValue,
          'default': true,
        }).whenComplete(() {
          return Navigator.pop(context);
        });
      } else {
        MyMessengerHelper.showSnackBar(scaffoldKey, "Pls select your location");
      }
    } else {
      MyMessengerHelper.showSnackBar(scaffoldKey, "Pls fill all the fields");
    }
    notifyListeners();
  }

  void setDefaultAddress(
      List<QueryDocumentSnapshot<Object?>> snap,
      QueryDocumentSnapshot<Object?> costumerAddress,
      BuildContext context) async {
    showProgress(context);
    for (var item in snap) {
      await defaultAddressFalse(item);
    }
    await defaultAddressTrue(costumerAddress)
        .whenComplete(() => updateProfileAddressAndPhone(costumerAddress));
    Future.delayed(const Duration(microseconds: 100))
        .whenComplete(() => Navigator.of(context).pop());

    notifyListeners();
  }

  Future defaultAddressFalse(dynamic item) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('customers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('address')
          .doc(item.id);
      transaction.update(documentReference, {'default': false});
    });
    notifyListeners();
  }

  Future defaultAddressTrue(
    QueryDocumentSnapshot<Object?> costumerAddress,
  ) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('customers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('address')
          .doc(costumerAddress['addressId']);
      transaction.update(documentReference, {'default': true});
    });
    notifyListeners();
  }

  Future updateProfileAddressAndPhone(
    QueryDocumentSnapshot<Object?> costumerAddress,
  ) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('customers')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      transaction.update(documentReference, {
        'address':
            '${costumerAddress['country']}-${costumerAddress['state']}-${costumerAddress['city']}-${costumerAddress['street']}-${costumerAddress['pincode']}',
        'phone': costumerAddress['phone']
      });
    });
    notifyListeners();
  }

  void showProgress(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(
        max: 100, msg: "Please Wait ... ", progressBgColor: Colors.black);
    notifyListeners();
  }

  void closeProgress(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.close();
    notifyListeners();
  }

  void deleteAddress(
    QueryDocumentSnapshot<Object?> costumerAddress,
  ) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference docsReference = FirebaseFirestore.instance
          .collection('customers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('address')
          .doc(costumerAddress['addressId']);
      transaction.delete(docsReference);
    });
    notifyListeners();
  }
}
