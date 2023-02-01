import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/utils/regex.dart';
import 'package:siopa/app/widget/app_bar.dart';

class UploadsScreen extends StatefulWidget {
  const UploadsScreen({super.key});

  @override
  State<UploadsScreen> createState() => _UploadsScreenState();
}

class _UploadsScreenState extends State<UploadsScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    var hmediaSize = MediaQuery.of(context).size.height;
    var wmediaSize = MediaQuery.of(context).size.width;

    var inputDecoration = InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: xBlue),
          borderRadius: BorderRadius.circular(25),
        ),
        labelText: 'Discount',
        contentPadding: const EdgeInsets.all(13),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: xBlack,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: hmediaSize * 0.25,
                          width: wmediaSize * 0.45,
                          child: const Center(
                            child: Text(
                              "       you haven't\n picked images yet !",
                              style: TextStyle(color: xWhite),
                            ),
                          ),
                        ),
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
                      ],
                    ),
                    hsizedBox,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: inputDecoration.copyWith(
                            labelText: 'Quantity',
                            hintText: "Enter the Quantity"),
                      ),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 100,
                        maxLines: 3,
                        keyboardType: TextInputType.name,
                        decoration: inputDecoration.copyWith(
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 1000,
                        maxLines: 7,
                        keyboardType: TextInputType.name,
                        decoration: inputDecoration.copyWith(
                            labelText: 'Product Description',
                            hintText: "Enter Product Description"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor: xBlue,
                onPressed: () {},
                child: const Icon(
                  Icons.photo_library,
                  color: xWhite,
                ),
              ),
            ),
            FloatingActionButton(
              backgroundColor: xBlue,
              onPressed: () {
                if (_form.currentState!.validate()) {
                  log("Valid");
                } else {
                  MyMessengerHelper.showSnackBar(
                      scaffoldKey, "Pls fill all fields");
                }
              },
              child: const Icon(
                Icons.upload,
                color: xWhite,
              ),
            )
          ],
        ),
      ),
    );
  }
}
