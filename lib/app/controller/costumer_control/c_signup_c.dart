import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/loginscreen.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;

class CostumerSignupProvider with ChangeNotifier {
  bool passwordVisible = false;
  late String name;
  late String email;
  late String password;
  late String profileImage;
  late String uid;
  late String uids;
  bool processing = false;
  XFile? _imgFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  CollectionReference customer =
      FirebaseFirestore.instance.collection('customers');

  signUp(BuildContext context, dynamic formKey, dynamic scaffoldKey) async {
    processing = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      if (_imgFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          firebasestorage.Reference ref = firebasestorage
              .FirebaseStorage.instance
              .ref('cus-images/$email.jpg');
          await ref.putFile(File(_imgFile!.path));

          uid = FirebaseAuth.instance.currentUser!.uid;
          profileImage = await ref.getDownloadURL();
          await customer.doc(uid).set({
            'name': name,
            'email': email,
            'profileimage': profileImage,
            'phone': '',
            'address': '',
            'cid': uid,
          });
          formKey.currentState!.reset();
          _imgFile = null;
          notifyListeners();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const CostumerLoginScreen(),
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
        MyMessengerHelper.showSnackBar(scaffoldKey, "Pls Pick a Image");
      }
    } else {
      processing = false;
      notifyListeners();
      MyMessengerHelper.showSnackBar(scaffoldKey, "Pls fill all fields");
    }
    notifyListeners();
  }

  void pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );

      _imgFile = pickedImage;
      notifyListeners();
    } catch (e) {
      _pickImageError = e;
      notifyListeners();
      log(_pickImageError);
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

      _imgFile = pickedImage;
      notifyListeners();
    } catch (e) {
      _pickImageError = e;
      notifyListeners();
      log(_pickImageError);
    }
    notifyListeners();
  }

  void passwordVisibily() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }
}
