import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/loginscreen.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';

class CostumerSignupProvider with ChangeNotifier {
  bool passwordVisible = false;
  late String name;
  late String email;
  late String password;
  late String uid;
  late String uids;
  bool processing = false;
  bool processings = false;

  CollectionReference customer =
      FirebaseFirestore.instance.collection('customers');

  signUp(BuildContext context, dynamic formKey, dynamic scaffoldKey) async {
    processing = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        uid = FirebaseAuth.instance.currentUser!.uid;
        await customer.doc(uid).set({
          'name': name,
          'email': email,
          'phone': '',
          'address': '',
          'cid': uid,
        });
        formKey.currentState!.reset();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => CostumerLoginScreen(),
        ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          processing = false;
          notifyListeners();
          MyMessengerHelper.showSnackBar(
              scaffoldKey, "The password provided is too weak");
        } else if (e.code == 'email-already-in-use') {
          processing = false;
          notifyListeners();
          MyMessengerHelper.showSnackBar(
              scaffoldKey, "The account with this email already exist");
        }
      }
    } else {
      processing = false;
      notifyListeners();
      MyMessengerHelper.showSnackBar(scaffoldKey, "Pls fill all fields");
    }
    notifyListeners();
  }

  void anonymousAuth() {
    FirebaseAuth.instance.signInAnonymously().whenComplete(() async {
      uids = FirebaseAuth.instance.currentUser!.uid;
      await customer.doc(uids).set({
        'name': '',
        'email': '',
        'profileimage': '',
        'phone': '',
        'address': '',
        'cid': uids,
      });
    });
    notifyListeners();
  }

  void passwordVisibily() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }
}
