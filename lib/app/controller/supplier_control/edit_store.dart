import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';

class EditStoreProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  XFile? imgFileLogo;
  XFile? imgFileCover;
  dynamic pickImageError;
  late String storeName;
  late String phone;
  late String storelogo;
  late String storeCover;
  bool processing = false;
  void pickStoreLogo() async {
    try {
      final pickedStoreLogo = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );

      imgFileLogo = pickedStoreLogo;
      notifyListeners();
    } catch (e) {
      pickImageError = e;
      notifyListeners();
      log(pickImageError);
    }
    notifyListeners();
  }

  void pickStoreCover() async {
    try {
      final pickedStoreCover = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );

      imgFileCover = pickedStoreCover;
      notifyListeners();
    } catch (e) {
      pickImageError = e;
      notifyListeners();
      log(pickImageError);
    }
    notifyListeners();
  }

  void resetLogo() {
    imgFileLogo = null;
    notifyListeners();
  }

  void resetCover() {
    imgFileCover = null;
    notifyListeners();
  }

  void saveChanges(dynamic data, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      processing = true;
      notifyListeners();
      await uploadstorelogo(data).whenComplete(() async {
        return await uploadStoreCover(data)
            .whenComplete(() => editStore(context));
      });
    } else {
      MyMessengerHelper.showSnackBar(scaffoldKey, "Pls fill the fields");
    }
    notifyListeners();
  }

  void editStore(BuildContext context) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('suppliers')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      transaction.update(documentReference, {
        'storename': storeName,
        'phone': phone,
        'storelogo': storelogo,
        'coverimage': storeCover,
      });
    }).whenComplete(() => Navigator.of(context).pop());
    notifyListeners();
  }

  Future<void> uploadstorelogo(dynamic data) async {
    if (imgFileLogo != null) {
      try {
        firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance
            .ref('sup-images/${data['email']}.jpg');
        await ref.putFile(File(imgFileLogo!.path));

        storelogo = (await ref.getDownloadURL());
      } catch (e) {
        log(e.toString());
      }
    } else {
      storelogo = data['storelogo'];
    }
    notifyListeners();
  }

  Future<void> uploadStoreCover(dynamic data) async {
    if (imgFileCover != null) {
      try {
        firebasestorage.Reference reff = firebasestorage
            .FirebaseStorage.instance
            .ref('sup-images/${data['email']}.jpg-cover');
        await reff.putFile(File(imgFileCover!.path));

        storeCover = await reff.getDownloadURL();
      } catch (e) {
        log(e.toString());
      }
    } else {
      storeCover = data['coverimage'];
    }
    notifyListeners();
  }
}
