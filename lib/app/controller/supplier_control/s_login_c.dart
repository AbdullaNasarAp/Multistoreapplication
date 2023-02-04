import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/sbottum_nav.dart';

class SupplierLoginProvider with ChangeNotifier {
  bool processing = false;

  late String email;
  late String password;
  bool passwordVisible = true;

  login(BuildContext context, dynamic formKey, dynamic scaffoldKey) async {
    processing = true;
    notifyListeners();

    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        formKey.currentState!.reset();

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const SupplierHomeScreen(),
        ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          processing = false;
          notifyListeners();
          MyMessengerHelper.showSnackBar(
              scaffoldKey, "No user exist with this email");
        } else if (e.code == 'wrong-password') {
          processing = false;
          notifyListeners();
          MyMessengerHelper.showSnackBar(scaffoldKey, "Password is Incorrect");
        }
      }
      processing = false;
      notifyListeners();
    } else {
      processing = false;
      notifyListeners();
      MyMessengerHelper.showSnackBar(scaffoldKey, "Pls fill all fields");
    }
    notifyListeners();
  }

  void passwordVisibily() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }
}
