import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';
import 'package:siopa/app/utils/category_list.dart';
import 'package:uuid/uuid.dart';

import '../../utils/colors.dart';

class UploadProvider with ChangeNotifier {
  late double proPrice;
  late int quantity;
  late String proName;
  late String proDesc;
  late String prodId;
  String mainCategoryValue = 'Select Category';
  String subCategoryValue = 'Subcategory';
  List<String> subCategoryList = [];

  List<XFile>? imgFileList = [];
  List<String> imgUrlList = [];
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  bool processing = false;

  Future<void> uploadImage(dynamic form, dynamic scaffoldKey) async {
    if (mainCategoryValue != "Select Category" &&
        subCategoryValue != "Subcategory") {
      if (form.currentState!.validate()) {
        form.currentState!.save();
        if (imgFileList!.isNotEmpty) {
          processing = true;
          notifyListeners();
          try {
            for (var image in imgFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');
              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imgUrlList.add(value);
                });
              });
            }
          } catch (e) {
            log("$e");
          }
        } else {
          MyMessengerHelper.showSnackBar(scaffoldKey, "Pls pick the Images");
        }
      } else {
        MyMessengerHelper.showSnackBar(scaffoldKey, "Pls fill all fields");
      }
    } else {
      MyMessengerHelper.showSnackBar(scaffoldKey, "Pls select the Category");
    }
    notifyListeners();
  }

  void uploadData(dynamic form) async {
    if (imgUrlList.isNotEmpty) {
      CollectionReference prodRef =
          FirebaseFirestore.instance.collection("products");
      prodId = const Uuid().v4();
      log(prodId);
      await prodRef.doc(prodId).set({
        'productId': prodId,
        'maincateg': mainCategoryValue,
        'subcateg': subCategoryValue,
        'price': proPrice,
        'instock': quantity,
        'prodname': proName,
        'proddesc': proDesc,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'prodimage': imgUrlList,
        'discount': 0
      }).whenComplete(() {
        processing = false;
        imgFileList = [];
        mainCategoryValue = 'Select Category';
        subCategoryList = [];
        imgUrlList = [];
        notifyListeners();
        form.currentState!.reset();
      });
      notifyListeners();
    } else {
      log("No Images");
    }
    notifyListeners();
  }

  void uploadProduct(dynamic form, dynamic scaffoldKey) async {
    await uploadImage(form, scaffoldKey).whenComplete(() => uploadData(form));
    notifyListeners();
  }

  void pickProductImage() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );

      imgFileList = pickedImages;
      notifyListeners();
    } catch (e) {
      _pickImageError = e;
      notifyListeners();
      log(_pickImageError);
    }
    notifyListeners();
  }

  Widget previewImages() {
    if (imgFileList!.isNotEmpty) {
      return ListView.builder(
        itemCount: imgFileList!.length,
        itemBuilder: (context, index) {
          return Image.file(File(imgFileList![index].path));
        },
      );
    } else {
      return const Center(
        child: Text(
          "       you haven't\n picked images yet !",
          style: TextStyle(color: xWhite),
        ),
      );
    }
  }

  void selectMainCateg(String? value) {
    if (value == "Select Category") {
      notifyListeners();
      subCategoryList = [];
    } else if (value == 'Men') {
      subCategoryList = men;
    } else if (value == 'Women') {
      subCategoryList = women;
    } else if (value == 'Electronics') {
      subCategoryList = electronics;
    } else if (value == 'Accessories') {
      subCategoryList = accessories;
    } else if (value == 'Shoes') {
      subCategoryList = shoes;
    } else if (value == 'Home & Garden') {
      subCategoryList = homeandgarden;
    } else if (value == 'Kids') {
      subCategoryList = kids;
    } else if (value == 'Bags') {
      subCategoryList = bags;
    } else if (value == 'Beauty') {
      subCategoryList = beauty;
    }
    notifyListeners();
    mainCategoryValue = value!;
    subCategoryValue = "Subcategory";
    notifyListeners();
  }

  void subcategValueset(String? value) {
    subCategoryValue = value!;
    notifyListeners();
  }

  void emptyImageList() {
    imgFileList = [];
    notifyListeners();
  }
}
