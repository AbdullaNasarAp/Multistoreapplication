import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/auth/loginscreen.dart';

class SupplierSignupProvider with ChangeNotifier {
  bool passwordVisible = true;

  late String storeName;
  late String email;
  late String password;
  late String storeLogo;
  late String uid;
  bool processing = false;
  XFile? imgFile;
  dynamic pickImageError;
  final ImagePicker _picker = ImagePicker();
  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

/////////////////////////////////////////////////////////////////////////////

  signUp(BuildContext context, dynamic scaffoldKeys, dynamic formKey) async {
    processing = true;

    notifyListeners();

    try {
      if (formKey.currentState!.validate()) {
        if (imgFile != null) {
          try {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email, password: password);

            try {
              await FirebaseAuth.instance.currentUser!.sendEmailVerification();
            } catch (e) {
              log(e.toString());
            }

            firebasestorage.Reference ref = firebasestorage
                .FirebaseStorage.instance
                .ref('sup-images/$email.jpg');
            await ref.putFile(File(imgFile!.path));

            uid = FirebaseAuth.instance.currentUser!.uid;
            storeLogo = await ref.getDownloadURL();

            await FirebaseAuth.instance.currentUser!
                .updateDisplayName(storeName);
            await FirebaseAuth.instance.currentUser!.updatePhotoURL(storeLogo);
            await suppliers.doc(uid).set({
              'storename': storeName,
              'email': email,
              'storelogo': storeLogo,
              'phone': '',
              'sid': uid,
              'coverimage': '',
            });

            formKey.currentState!.reset();

            imgFile = null;
            notifyListeners();
            processing = false;
            notifyListeners();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SupplierLoginScreen(),
            ));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              processing = false;
              notifyListeners();
              MyMessengerHelper.showSnackBar(
                  scaffoldKeys, "The password provided is too weak");
            } else if (e.code == 'email-already-in-use') {
              processing = false;
              notifyListeners();
              MyMessengerHelper.showSnackBar(
                  scaffoldKeys, "The account with this email already exist");
            }
          }
        } else {
          processing = false;
          notifyListeners();
          MyMessengerHelper.showSnackBar(scaffoldKeys, "Pls Pick a Image");
        }
      } else {
        processing = false;
        notifyListeners();
        MyMessengerHelper.showSnackBar(scaffoldKeys, "Pls fill all fields");
      }
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////////////
  void pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );

      imgFile = pickedImage;
      notifyListeners();
    } catch (e) {
      pickImageError = e;
      notifyListeners();
      log(pickImageError);
    }
    notifyListeners();
  }

  void pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );

      imgFile = pickedImage;
      notifyListeners();
    } catch (e) {
      pickImageError = e;
      notifyListeners();
      log(pickImageError);
    }
    notifyListeners();
  }

  void passwordVisibily() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }
}
