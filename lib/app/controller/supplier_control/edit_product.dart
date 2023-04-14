import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';
import 'package:siopa/app/utils/category_list.dart';
import '../../utils/colors.dart';

class EditProductProvider with ChangeNotifier {
  late double proPrice;
  late int quantity;
  late String proName;
  late int? discount = 0;
  late String proDesc;
  late String prodId;
  String mainCategoryValue = 'Select Category';
  String subCategoryValue = 'Subcategory';
  List<String> subCategoryList = [];

  List<XFile>? imgFileList = [];
  List<dynamic> imgUrlList = [];
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  bool processing = false;

  Future uploadPickedImges(
      dynamic items, dynamic scaffoldKey, dynamic form) async {
    if (form.currentState!.validate()) {
      form.currentState!.save();
      if (imgFileList!.isNotEmpty) {
        if (mainCategoryValue != "Select Category" &&
            subCategoryValue != "Subcategory") {
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
          MyMessengerHelper.showSnackBar(
              scaffoldKey, "Pls select the Category");
        }
      } else {
        imgUrlList = items['prodimage'];
      }
    } else {
      MyMessengerHelper.showSnackBar(scaffoldKey, "Pls fill all fields");
    }

    notifyListeners();
  }

  void editProduct(dynamic items, BuildContext context) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('products')
          .doc(items['productId']);
      transaction.update(documentReference, {
        // 'maincateg': mainCategoryValue,
        // 'subcateg': subCategoryValue,
        'price': proPrice,
        'instock': quantity,
        'prodname': proName,
        'proddesc': proDesc,
        'prodimage': imgUrlList,
        'discount': discount
      });
    }).whenComplete(() => Navigator.pop(context));
    notifyListeners();
  }

  void saveChanges(dynamic items, BuildContext context, dynamic scaffoldKey,
      dynamic form) async {
    await uploadPickedImges(items, scaffoldKey, form)
        .whenComplete(() => editProduct(items, context));
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

  Widget previewCurrentImages(dynamic items) {
    List<dynamic> itemsImages = items['prodimage'];
    return ListView.builder(
      itemCount: itemsImages.length,
      itemBuilder: (context, index) {
        return Image.network(itemsImages[index].toString());
      },
    );
  }

  deleteProduct(dynamic items, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: xWhite,
        title: const Text(
          "Delete Product",
          style: TextStyle(color: xBlack),
        ),
        content: const Text(
          "Are you sure to Delete the Product",
          style: TextStyle(color: xBlack),
        ),
        actions: [
          OutlinedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(xBlue)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "No",
              style: TextStyle(color: xWhite),
            ),
          ),
          OutlinedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(xBlue)),
            onPressed: () async {
              await FirebaseFirestore.instance
                  .runTransaction((transaction) async {
                DocumentReference documentReference = FirebaseFirestore.instance
                    .collection('products')
                    .doc(items['productId']);
                transaction.delete(documentReference);
              }).whenComplete(() => Navigator.pop(context));
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: xWhite),
            ),
          ),
        ],
      ),
    );
    notifyListeners();
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
