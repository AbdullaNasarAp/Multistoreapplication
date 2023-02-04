import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';
import 'package:siopa/app/utils/category_list.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/utils/regex.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/button_container.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadsScreen extends StatefulWidget {
  const UploadsScreen({super.key});

  @override
  State<UploadsScreen> createState() => _UploadsScreenState();
}

class _UploadsScreenState extends State<UploadsScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double proPrice;
  late int quantity;
  late String proName;
  late String proDesc;
  late String prodId;
  String mainCategoryValue = 'Select Category';
  String subCategoryValue = 'Subcategory';
  List<String> subCategoryList = [];

  List<XFile>? _imgFileList = [];
  List<String> _imgUrlList = [];
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    var hmediaSize = MediaQuery.of(context).size.height;
    var wmediaSize = MediaQuery.of(context).size.width;

    var inputDecoration = InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: xBlue),
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding: const EdgeInsets.all(20),
        alignLabelWithHint: true,
        labelStyle: const TextStyle(color: xWhite),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: xBlue),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: xGreen),
          borderRadius: BorderRadius.circular(25),
        ));
    const wsizedBox = SizedBox(
      width: 20,
    );
    const hsizedBox = SizedBox(
      height: 20,
    );
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        backgroundColor: xBlack87,
        appBar: AppBar(
          title: const AppBarTitle(title: "Uploads"),
        ),
        body: Container(
          color: xBlack87,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: xBlack,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: hmediaSize * 0.25,
                          width: wmediaSize * 0.45,
                          child: _imgFileList != null
                              ? previewImages()
                              : const Center(
                                  child: Text(
                                    "       you haven't\n picked images yet !",
                                    style: TextStyle(color: xWhite),
                                  ),
                                ),
                        ),
                        Column(
                          children: [
                            const TextTitle(
                                title: "Select main Category",
                                ls: 0,
                                fontwght: FontWeight.normal,
                                fontsz: 13),
                            DropdownButton(
                              alignment: Alignment.centerLeft,
                              menuMaxHeight: 150,
                              value: mainCategoryValue,
                              focusColor: xBlue,
                              dropdownColor: xBlack,
                              items: maincateg
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: TextTitle(
                                      title: value,
                                      ls: 0,
                                      fontwght: FontWeight.normal,
                                      fontsz: 13),
                                );
                              }).toList(),
                              onChanged: (value) {
                                selectMainCateg(value);
                              },
                            ),
                            hsizedBox,
                            const TextTitle(
                                title: "Select subCategory",
                                ls: 0,
                                fontwght: FontWeight.normal,
                                fontsz: 13),
                            DropdownButton(
                              alignment: Alignment.centerLeft,
                              menuMaxHeight: 150,
                              disabledHint: const Text("Select Category"),
                              value: subCategoryValue,
                              focusColor: xBlue,
                              dropdownColor: xBlack,
                              items: subCategoryList
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: TextTitle(
                                      title: value,
                                      ls: 0,
                                      fontwght: FontWeight.normal,
                                      fontsz: 13),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  subCategoryValue = value!;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1.3,
                      color: xBlack,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: wmediaSize * 0.45,
                          child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the Price";
                                } else if (value.isValidPrice() != true) {
                                  return "Enter a valid Price";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                proPrice = double.parse(newValue!);
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: inputDecoration.copyWith(
                                  labelText: 'Price',
                                  hintText: "ProductPrice")),
                        ),
                        wsizedBox,
                        _imgFileList!.isEmpty
                            ? RawMaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(15),
                                fillColor: xBlue,
                                onPressed: () {
                                  pickProductImage();
                                },
                                child: const TextTitle(
                                    title: "Select Image",
                                    ls: 0,
                                    fontwght: FontWeight.normal,
                                    fontsz: 16),
                              )
                            : RawMaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(15),
                                fillColor: xBlue,
                                onPressed: () {
                                  setState(() {
                                    _imgFileList = [];
                                  });
                                },
                                child: const TextTitle(
                                    title: "Delete Image",
                                    ls: 0,
                                    fontwght: FontWeight.normal,
                                    fontsz: 16),
                              )
                      ],
                    ),
                    hsizedBox,
                    Row(
                      children: [
                        SizedBox(
                          width: wmediaSize * 0.45,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the Discount";
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            decoration: inputDecoration.copyWith(
                                labelText: 'Discount',
                                hintText: "Product Discount"),
                          ),
                        ),
                        wsizedBox,
                        SizedBox(
                          width: wmediaSize * 0.45,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the Quantity";
                              } else if (value.isValidQuantity() != true) {
                                return "Enter valid quantity";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              quantity = int.parse(newValue!);
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            decoration: inputDecoration.copyWith(
                                labelText: 'Quantity',
                                hintText: "Enter the Quantity"),
                          ),
                        ),
                      ],
                    ),
                    hsizedBox,
                    SizedBox(
                      width: wmediaSize * 100,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the Product Name";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          proName = value!;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 100,
                        maxLines: 3,
                        keyboardType: TextInputType.name,
                        decoration: inputDecoration.copyWith(
                            alignLabelWithHint: true,
                            labelText: 'Product Name',
                            hintText: "Enter Product Name"),
                      ),
                    ),
                    hsizedBox,
                    SizedBox(
                      width: wmediaSize * 100,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the Product Description";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          proDesc = value!;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 1000,
                        maxLines: 7,
                        keyboardType: TextInputType.name,
                        decoration: inputDecoration.copyWith(
                            alignLabelWithHint: true,
                            labelText: 'Product Description',
                            hintText: "Enter Product Description"),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: processing == true
                          ? const CircularProgressIndicator()
                          : RawMaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(15),
                              fillColor: xBlue,
                              onPressed: processing == true
                                  ? null
                                  : () {
                                      uploadProduct();
                                    },
                              child: const TextTitle(
                                  title: "Upload",
                                  ls: 0,
                                  fontwght: FontWeight.normal,
                                  fontsz: 16),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage() async {
    if (mainCategoryValue != "Select Category" &&
        subCategoryValue != "Subcategory") {
      if (_form.currentState!.validate()) {
        _form.currentState!.save();
        if (_imgFileList!.isNotEmpty) {
          setState(() {
            processing = true;
          });
          try {
            for (var image in _imgFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');
              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  _imgUrlList.add(value);
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
  }

  void uploadData() async {
    if (_imgUrlList.isNotEmpty) {
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
        'prodimage': _imgUrlList,
        'discount': 0
      }).whenComplete(() {
        setState(() {
          processing = false;
          _imgFileList = [];
          mainCategoryValue = 'Select Category';
          subCategoryList = [];
          _imgUrlList = [];
        });
        _form.currentState!.reset();
      });
    } else {
      log("No Images");
    }
  }

  void uploadProduct() async {
    await uploadImage().whenComplete(() => uploadData());
  }

  void pickProductImage() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );
      setState(() {
        _imgFileList = pickedImages;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      log(_pickImageError);
    }
  }

  Widget previewImages() {
    if (_imgFileList!.isNotEmpty) {
      return ListView.builder(
        itemCount: _imgFileList!.length,
        itemBuilder: (context, index) {
          return Image.file(File(_imgFileList![index].path));
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
    setState(() {
      mainCategoryValue = value!;
      subCategoryValue = "Subcategory";
    });
  }
}
