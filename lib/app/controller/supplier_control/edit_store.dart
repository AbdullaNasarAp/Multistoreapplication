import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditStoreProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  XFile? imgFileLogo;
  XFile? imgFileCover;
  dynamic pickImageError;
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
}
